#!/usr/bin/env bash
GIT_DIR="$HOME/4cachy"

cd "$GIT_DIR" || { echo -e "\n   * Git Directory not found!\n"; exit; }

while true; do

  clear; echo -e "\n   ...  GIT AUTOMATION SCRIPT ...\n"
  
  echo "   > Choose an option:"; echo
  echo "     1. Commit"
  echo "     2. Edit last commit message"; echo

  read -p "     > Option: " gas

  case "$gas" in
    
    1)
       clear; echo -e "\n   ...  NEW COMMIT IN PROGRESS ...\n"
       echo; read -p "   > Enter commit message: " mas

       git add .
       echo; git commit -m "$mas" || exit
       echo; git push origin main || exit

       echo -e "\n   ...  COMMIT SUCCESSFUL ...\n"; exit
       ;;
    2)
       clear; echo -e "\n   ...  EDITING LAST COMMIT MESSAGE ...\n"
       echo; read -p "   > Enter new commit message: " nas

       echo; git commit --amend -m "$nas" || exit
       echo; git push --force             || exit

       echo -e "\n   ...  EDITED LAST COMMIT MESSAGE, FORCE PUSHED ...\n"; exit
       ;;
    *)
       clear; echo -e "\n   * Invalid response received, try again\n"; sleep 2
       ;;
  esac
done
