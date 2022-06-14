
# https://minsw.github.io/fzf-color-picker/
set -x FZF_DEFAULT_OPTS "\
--layout=reverse --height=60% \
--color=bg+:#302D41,\
bg:#1E1E2E,\
spinner:#F8BD96,\
hl:#F28FAD \
--color=fg:#D9E0EE,\
preview-fg:#04a5e5,\
header:#F28FAD,\
info:#DDB6F2,\
pointer:#F8BD96 \
--color=marker:#F8BD96,\
fg+:#F2CDCD,\
prompt:#DDB6F2,\
hl+:#F28FAD"


# Use ripgrep instead for fzf
if type -q rg
    set -Ux FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!{node_modules,.git}\""
end

# Key bindings
if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\cp --history=\cr --git_log=\cg
end
