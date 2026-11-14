#!/usr/bin/env bash
# Copia o tema e os snippets (brilho e fontes) para um cofre do Obsidian.
# Uso: ./obsidian/install.sh "/caminho/do/cofre"
set -euo pipefail

vault="${1:?informe o caminho do cofre}"
source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(dirname "$source_dir")"
config_dir="$vault/.obsidian"

[[ -d "$config_dir" ]] || { echo "não é um cofre do Obsidian: $vault" >&2; exit 1; }

mkdir -p "$config_dir/themes/Ardentia" "$config_dir/snippets"
cp "$source_dir/theme.css" "$repo_dir/manifest.json" "$config_dir/themes/Ardentia/"
cp "$source_dir"/snippets/*.css "$config_dir/snippets/"

echo "Ardentia instalado em $config_dir"
echo "Escolha o tema em Configurações, Aparência, Temas."
