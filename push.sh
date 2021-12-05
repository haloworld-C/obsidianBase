#! /bin/bash
# update throuht git tool by halo
echo "begin to push current repo.."
now=$(date "+%Y-%m-%d")
git add -A && git commit -m "$now" && git pull origin main && git push origin main
echo "git push finished!"
