---
name: mprocs-ctl
description: Use the mprocs remote control API to inspect and manage processes running in an mprocs instance. Use when you need to list running processes, check their status, read their terminal output, control them (start/stop/restart), or pin/unpin processes to the top of the sidebar via the TCP remote control interface.
---

# mprocs Remote Control Skill

## Description
mprocs exposes a TCP remote control API when started with `--server`. You can send YAML-encoded commands to inspect and control processes from scripts or agents.

## Prerequisites

mprocs must be running with a server address:
```bash
mprocs --server 127.0.0.1:4050 "cmd1" "cmd2"
```

The binary is at `~/.local/bin/mprocs` (installed via `task install` from the repo).

> **Important:** The running mprocs instance uses whichever binary it was launched with. If you rebuild the binary, you must restart mprocs for changes to take effect. Check which binary is in use with `lsof -p <pid> | grep txt`.

## List All Processes

Returns a JSON array of all processes with their index, name, running status, and exit code.

```bash
mprocs --ctl '{c: list-procs}' --server 127.0.0.1:4050
```

Example response:
```json
[
  { "index": 0, "name": "api", "group": "web", "is_up": true, "exit_code": null },
  { "index": 1, "name": "api", "group": "worker", "is_up": false, "exit_code": 0 },
  { "index": 2, "name": "api", "group": "payments", "is_up": false, "exit_code": 1 }
]
```

Fields:
- `index` — zero-based position in the process list
- `name` — process name from config
- `group` — group name if the process belongs to a group, omitted otherwise
- `is_up` — `true` if process is currently running
- `exit_code` — last exit code, or `null` if never exited or currently running

> **Note:** Many processes may share the same `name` (e.g. all named `"api"`). Use `group` + `name` together to identify a specific process, and use `index` when sending control commands.

## Get Process Output

Reads the terminal scrollback buffer of a process. Identify by index or name.

```bash
# By index
mprocs --ctl '{c: get-output, index: 0, lines: 50}' --server 127.0.0.1:4050

# By name
mprocs --ctl '{c: get-output, name: "web", lines: 100}' --server 127.0.0.1:4050
```

Parameters:
- `index` — process index (from `list-procs`)
- `name` — process name (alternative to index)
- `lines` — number of lines to return from scrollback (0 = all)

## Control Processes

All control commands use the same pattern. Use `select-proc` first to target a process, then send the action.

> **Important:** `select-proc` must be sent before every control command — it sets which process the action will apply to. In configs where processes are grouped, groups start collapsed. `select-proc` will auto-expand the group if needed (requires a build with this fix — older builds silently fail if the target proc is in a collapsed group, leaving the previously selected proc as the target).

```bash
# Select process by index
mprocs --ctl '{c: select-proc, index: 2}' --server 127.0.0.1:4050

# Start the selected process
mprocs --ctl '{c: start-proc}' --server 127.0.0.1:4050

# Stop the selected process (SIGTERM)
mprocs --ctl '{c: term-proc}' --server 127.0.0.1:4050

# Kill the selected process (SIGKILL)
mprocs --ctl '{c: kill-proc}' --server 127.0.0.1:4050

# Restart the selected process
mprocs --ctl '{c: restart-proc}' --server 127.0.0.1:4050
```

## Pin / Unpin Processes

Pinned processes are moved to a "Pinned" group at the top of the sidebar and remain visible even when a text filter is active. In the UI, press `p` to toggle pin on the selected process. Via remote control:

```bash
# Pin by index
mprocs --ctl '{c: pin-proc, index: 6}' --server 127.0.0.1:4050

# Unpin by index
mprocs --ctl '{c: unpin-proc, index: 6}' --server 127.0.0.1:4050

# Toggle pin on currently selected process
mprocs --ctl '{c: toggle-pin}' --server 127.0.0.1:4050
```

Pinned procs are displayed as `group/name` (e.g. `clocky/api`) for disambiguation since many procs share the name `"api"`. Use `list-procs` to find the index first.

## Batch Multiple Commands

Send multiple commands in one call. **Always prefer batch over separate calls** — combine select, control, and pin operations together:
```bash
# Start and pin a process in one call
mprocs --ctl '{c: batch, cmds: [{c: select-proc, index: 1}, {c: start-proc}, {c: pin-proc, index: 1}]}' --server 127.0.0.1:4050

# Restart without pinning
mprocs --ctl '{c: batch, cmds: [{c: select-proc, index: 1}, {c: restart-proc}]}' --server 127.0.0.1:4050
```

## Typical Agent Workflow

1. **Discover processes** — run `list-procs` to get names and indices
2. **Check which are running** — filter by `is_up: true`
3. **Read output** — use `get-output` with the process name or index
4. **Act** — select the process by index, then start/stop/restart as needed

```bash
# 1. List all processes
mprocs --ctl '{c: list-procs}' --server 127.0.0.1:4050

# 2. Read output of a specific service
mprocs --ctl '{c: get-output, name: "api", lines: 100}' --server 127.0.0.1:4050

# 3. Restart and pin it by index (e.g. index 2)
mprocs --ctl '{c: batch, cmds: [{c: select-proc, index: 2}, {c: restart-proc}, {c: pin-proc, index: 2}]}' --server 127.0.0.1:4050
```

## Error Handling

- If mprocs is not running on the server address, the command will fail to connect. In this case, inform the user and ask them to start mprocs themselves — do not attempt to start it.
- `get-output` returns an error string (prefixed `ERROR:`) if the process index/name is invalid or has no output yet.
- Control commands (start/stop/restart) operate on the currently selected process — always `select-proc` first.
- If `select-proc` silently does nothing (e.g. on older builds), the process may be in a collapsed group. Restart mprocs with a current build to fix this.

## Notes

- All commands are YAML — single-quoted braces `'{c: ...}'` work in bash.
- `list-procs` and `get-output` write their response to stdout and exit.
- Other commands (start/stop/restart etc.) are fire-and-forget with no response.
- The default server port used in this project is `127.0.0.1:4050`.
