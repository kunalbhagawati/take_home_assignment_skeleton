#!/usr/bin/env bash

rm Readme.md
mv Readme.candidate.md Readme.md

rm -rf .git/

git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then
  git init
  git add --all
  git commit -m "First commit"
fi

rm -rf build.sh
