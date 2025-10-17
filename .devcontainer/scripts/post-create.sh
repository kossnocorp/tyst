#!/usr/bin/env bash

# This script is run after the container is created.

set -e

source ~/.config/mothership/.env || true

# Make sure mise is activated
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
eval "$(mise activate bash --shims)"
eval "$(mise env -s bash)"
