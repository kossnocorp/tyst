#!/usr/bin/env bash

set -eo pipefail

./scripts/build.sh
echo ""

echo -e "⚡️ Publishing package\n"

root_dir="$(dirname "$0")/.."
cd "$root_dir/dist"

echo "🌀 Preparing pnpm workspace"
workspace_file="pnpm-workspace.yaml"
cp "../$workspace_file" ./
sed -i 's|"submodules/tdollar"|"../submodules/tdollar"|g' "./$workspace_file"

pnpm install > /dev/null 2>&1

if [[ "$1" == "next" ]]; then
  echo "🌀 Publishing as prerelease"
  pnpm publish --access public --no-git-checks --tag next
else
  echo "🌀 Publishing as latest"
  pnpm publish --access public --no-git-checks
fi

echo -e "\n💚 The package is ready!"