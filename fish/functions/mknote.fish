function mknote  --description "Make a markdown file for notes" 
    set noteTitle $argv   

    printf (string join $noteTitle '#' "") > $noteTitle.md
end
