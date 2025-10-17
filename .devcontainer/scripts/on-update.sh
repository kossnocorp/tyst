#!/usr/bin/env bash

# This script is when the container is updated.

set -e

source ~/.config/mothership/.env || true

# Make sure mise is activated
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
eval "$(mise activate bash --shims)"
eval "$(mise env -s bash)"

# Pull git submodules
if [ -e .git ]; then
  git submodule update --recursive --init --remote
fi

# Trust all mise configs
mise trust --yes --all
if [ -d .git ]; then
  git submodule foreach --recursive "mise trust"
fi

# Update mise
mise self-update -y

# Install stack
mise install

# Enable corepack
npx corepack enable || true

# Install dependencies
if [ -f ./pnpm-lock.yaml ]; then
  yes | pnpm install
elif [ -f ./yarn.lock ]; then
  yes | yarn install
elif [ -f ./package-lock.json ]; then
  yes | npm install
fi
