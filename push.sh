#! /bin/bash
# update throuht git tool by halo
echo "begin to push current repo.."
now=$(date "+%Y-%m-%d")
read -p "please input commit comments:" msg
git add -A && git commit -m "$now"-"$msg" && git pull origin main && git push origin main
echo "git push finished!"
