# Pacman

## Add package
`sudo pacman -S packageName`

## Remove package
`sudo pacman -R packageName`

## Search for package
`pacman -Ss searchQuery`


## Update packages
`sudo pacman -Syu`

## Update Mirrorlist
- Go to https://archlinux.org/mirrorlist and generate mirrorlist
- Copy the urls and paste to `/etc/pacman.d/mirrorlist`
- Uncomment lines that start with "Server" 
- Run `sudo pacman -Syy`
