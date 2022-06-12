function set_title
	set -l title $argv[1]
    function fish_title --inherit-variable title
        echo "$title"
    end
end
