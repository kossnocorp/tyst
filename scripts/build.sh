#!/usr/bin/env bash

set -eo pipefail

echo -e "⚡️ Building package\n"

root_dir="$(dirname "$0")/.."
cd "$root_dir"

rm -rf ./dist/
mkdir ./dist/

echo "🌀 Running tsc"
pnpm tsc

echo "🌀 Copying package files"
cp {*.md,package.json} ./dist/

echo -e "\n💚 The package is ready!"