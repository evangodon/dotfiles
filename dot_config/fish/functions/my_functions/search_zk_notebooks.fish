function search_zk_notebooks  --description "Search all .zk notebooks and open a file with editor" 
  # Get all notes and display in fzf
  set -l notes_dir $HOME/notes

  if ! test -d "$notes_dir";
    echo "$notes_dir" not found on this machine
    return 1
  end

  set -l notebooks (fd --hidden ^.zk --type d --maxdepth 3 $notes_dir | xargs dirname)

  set -l selected_notebook (echo $notebooks \
                                 | tr ' ' '\n' \
                                 |  fzf --delimiter $notes_dir --with-nth -1)

    if ! test -n "$selected_notebook";
      commandline -f repaint
      return 
    end

  # Display all notes in that notebook with custom_fzf_preview
  custom_fzf_search_dir --directory=$selected_notebook

  return
end
