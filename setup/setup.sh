# Install nix package manager
curl -L https://nixos.org/nix/install | sh

# Install packages
nix-env -iA nixpkgs.fish    \
nixpkgs.fzf                 \
nixpkgs.fd                  \
nixpkgs.lazygit             \
nixpkgs.pgcli               \
nixpkgs.ncdu                \
nixpkgs.bottom              

# Change default shell to fish

# Install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Install fisher plugins
fisher install         \
jethrokuan/z           \
jorgebucaran/nvm.fish  \
PatrickF1/fzf.fish     \
franciscolourenco/done \
victante/trish         \
lilyball/nix-env.fish

# Install kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# TODO: let's do this script in go, test in a VM
# Download node, cargo, go, pipx
