function journal -d "Start a new journal entry"
    echo \n(date +"%a %b %d, %Y")\n--- >> ~/work/lane-notes/Journal.md

    nvim ~/work/lane-notes/Journal.md
end
