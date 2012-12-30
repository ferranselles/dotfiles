#!/bin/sh

# From https://help.github.com/articles/set-up-git

git config --global user.name "NAME"
git config --global user.email "MAIL"

# Set git to use the osxkeychain credential helper
# TODO: check: git credential-osxkeychain
git config --global credential.helper osxkeychain

