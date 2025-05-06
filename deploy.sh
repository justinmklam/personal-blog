#!/bin/sh
# Usage:
# ./deploy.sh
# ./deploy.sh "Your optional commit message"

# If a command fails then the deploy stops
set -e

printf "\033[0;32mRebuilding website...\033[0m\n"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To publish folder
cd docs

# Add changes to git.
git add .

# Commit changes.
msg="Rebuild site ($(date))"
if [ -n "$*" ]; then
	msg="${msg}: $*"
fi
git commit -m "$msg"

printf "\033[0;32mPushing updates to GitHub...\033[0m\n"

# Push source and build repos.
git push origin main
