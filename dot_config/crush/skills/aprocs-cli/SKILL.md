---
name: aprocs-cli
description: Use aprocs to control aprocs process supervisor — start, stop, restart processes, check logs, and inspect process metadata. Use when working with aprocs, managing background processes, checking process state, or reading process output.
---

# aprocs CLI skill

`aprocs` is a process supervisor. The daemon owns all managed processes. Control them via `aprocs ctl`.

## Daemon management

```bash
aprocs daemon start --config <path>   # start daemon (required before ctl commands)
aprocs daemon stop                    # stop daemon and all processes
aprocs daemon status                  # check if daemon is running
```

The TUI (`aprocs --config <path>`) auto-starts the daemon. For agent use, start it explicitly.

## Process control

```bash
aprocs ctl list                       # list all processes with state, PID, uptime
aprocs ctl start <name>               # start a stopped process
aprocs ctl stop <name>                # stop a running process
aprocs ctl restart <name>             # stop + clear logs + start
aprocs ctl inspect <name>             # PID, state, uptime, restart count, exit code
aprocs ctl logs <name> --n 50         # tail last N lines of output
```

## Process states

- `running` — process is alive
- `stopped` — stopped intentionally
- `failed` — exited unexpectedly (non-zero exit code)

## Config (`aprocs.yaml`)

```yaml
version: 1
procs:
  api:
    cmd: go
    args: ["run", "./cmd/api"]
    autostart: true
    stop_signal: SIGTERM
    stop_timeout: 10s
```

## Workflow

1. Check state: `aprocs ctl list`
2. Read logs if needed: `aprocs ctl logs <name>`
3. Take action: `aprocs ctl start|stop|restart <name>`
4. Verify: `aprocs ctl inspect <name>`

## Notes

- Always check `aprocs daemon status` before running ctl commands
- `restart` clears the log buffer — use it instead of stop+start
- Log files persist at `~/.local/share/aprocs/logs/<name>.log`
