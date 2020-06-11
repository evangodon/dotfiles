function journal -d "Start a new journal entry"
    echo \n(date +"%a %b %d, %Y")\n--- >> ~/work/notes/journal.md

    nvim ~/work/notes/journal.md
end
