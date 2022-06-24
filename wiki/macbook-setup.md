---
title: Macbook setup
---

# Change keyboard shortcut for changing desktops

# SSH
- [ ] Generate ssh key: `ssh-keygen -t ed25519`
- [ ] Copy public key to macbook: `ssh-copy-id me@mabook_address` 
- [ ] Add new host to `~/.ssh/config`

# Shell
- [ ] Install fish
- [ ] Install fisher
- [ ] Install promt (`github.com/pure-fish/pure` is nice)
    - [ ] Set promt symbol to Apple  (Need NerdFont installed)
- [ ] Install `github.com/jethrokuan/z`

# GitHub
- [ ] Add ssh key to GitHub saved keys
- [ ] Configure SSO if needed


# Troubleshooting

- Restart wifi
`alias restart_en0='sudo ifconfig en0 down && sudo ifconfig en0 up'`
-> note this will disconnect ssh session


# Ressources
- Check out https://karabiner-elements.pqrs.org/
- App launcher https://www.raycast.com/
