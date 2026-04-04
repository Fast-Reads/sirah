#!/bin/bash
git config --global user.name "Fast-Reads"
git config --global user.email "Fast-Reads@users.noreply.github.com"
echo "Enter commit message:"
read msg
git add .
git commit -m "$msg"
git push
