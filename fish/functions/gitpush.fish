function gitpush --description "Git add all files and push to repo"

  git add .

  echo 'Commit message:'
  read commitMessage

  git commit -m "$commitMessage"

  echo 'Push to this branch'
  read branch

  git push origin $branch

  echo 'Pushed changes to $branch branch'

end
