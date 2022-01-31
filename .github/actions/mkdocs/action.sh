#!/bin/bash

set -e

REQUIREMENTS="${GITHUB_WORKSPACE}/requirements.txt"

if [ -f "${REQUIREMENTS}" ]; then
    pip install -r "${REQUIREMENTS}"
fi

if [ -n "${GITHUB_TOKEN}" ]; then
    remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
elif [ -n "${PERSONAL_TOKEN}" ]; then
    remote_repo="https://x-access-token:${PERSONAL_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
fi

git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "$GITHUB_ACTOR@users.noreply.github.com"

mkdocs build --config-file "${GITHUB_WORKSPACE}/mkdocs.yml"

git clone --branch=gh-pages --depth=1 "${remote_repo}" gh-pages
cd gh-pages

# copy current index file index.yaml before any change
temp_worktree=$(mktemp -d)
cp --force "index.yaml" "$temp_worktree/index.yaml"
# remove current content in branch gh-pages
git rm -r .
# copy new doc.
cp -r ../site/* .
# restore chart index
cp "$temp_worktree/index.yaml" .
# commit changes
git add .
git commit -m "Deploy GitHub Pages"
git push --force --quiet "${remote_repo}" gh-pages > /dev/null 2>&1
