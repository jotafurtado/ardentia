#!/usr/bin/env bash
# Copia a extensão do tema para a pasta de extensões do VS Code.
# Uso: ./vscode/install.sh
#   VSCODE_EXTENSIONS_DIR  pasta de extensões de destino (padrão: ~/.vscode/extensions)
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
extensions_dir="${VSCODE_EXTENSIONS_DIR:-$HOME/.vscode/extensions}"

# A versão vem do package.json, lida com sed para não depender de jq.
version="$(sed -n 's/^[[:space:]]*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*$/\1/p' "$source_dir/package.json" | head -n 1)"
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "versão não encontrada em $source_dir/package.json" >&2; exit 1; }

# A pasta leva o id da extensão (publisher.name) seguido da versão.
target_dir="$extensions_dir/jotafurtado.ardentia-$version"

# Só a pasta desta extensão é substituída. O resto da pasta de extensões fica como está.
rm -rf "$target_dir"
mkdir -p "$target_dir/themes"
cp "$source_dir/package.json" \
  "$source_dir/README.md" \
  "$source_dir/README.pt-BR.md" \
  "$source_dir/CHANGELOG.md" \
  "$source_dir/LICENSE" \
  "$target_dir/"
cp "$source_dir"/themes/*.json "$target_dir/themes/"

echo "Ardentia $version instalado em $target_dir"
echo "Reinicie o VS Code e escolha Ardentia com o comando Preferences: Color Theme."
