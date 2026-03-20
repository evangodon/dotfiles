---
name: git-rebase
description: Use when rebasing in git. Always set GIT_EDITOR=true to prevent an interactive editor from opening and blocking execution.
---

Always prefix rebase commands with `GIT_EDITOR=true` to avoid getting stuck in an editor:

```bash
GIT_EDITOR=true git rebase main
GIT_EDITOR=true git rebase --continue
GIT_EDITOR=true git rebase --abort
```

## Squashing commits

When squashing multiple commits that touch the same files, **prefer `git reset --soft` over interactive rebase with `squash`**. Interactive rebase replays each commit individually and generates conflicts when the same file is modified across commits being squashed. `git reset --soft` avoids this entirely by collapsing everything into the working tree at once.

```bash
# Squash all commits since diverging from master into clean groups
git reset --soft origin/master

# Then re-commit in logical groups by staging specific files
git commit --only file1.go file2.go -m "feat: group one"
git commit --only file3.go file4.go -m "feat: group two"

# Force push (use --force-with-lease, not --force)
git push --force-with-lease
```

`--force-with-lease` is safer than `--force` — it refuses to push if someone else has pushed to the branch since your last fetch, preventing accidental overwrites.
