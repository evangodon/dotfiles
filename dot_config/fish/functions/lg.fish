function lg --wraps=lazitgit --wraps=lazygit --description 'alias lg lazygit'
    if not type -q lazygit
        echo "lazygit not installed"
        return 1
    end

    lazygit  $argv; 
end
