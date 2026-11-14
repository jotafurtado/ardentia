#!/usr/bin/env bash
# Copia o tema e os snippets (brilho e fontes) para um cofre do Obsidian.
# Uso: ./obsidian/install.sh [--dev] "/caminho/do/cofre"
#   --dev  instala como "Ardentia (Dev)", para conviver com o tema instalado pelo diretório da comunidade
set -euo pipefail

theme_name="Ardentia"
if [[ "${1:-}" == "--dev" ]]; then
  theme_name="Ardentia (Dev)"
  shift
fi

vault="${1:?informe o caminho do cofre}"
source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(dirname "$source_dir")"
config_dir="$vault/.obsidian"
theme_dir="$config_dir/themes/$theme_name"

[[ -d "$config_dir" ]] || { echo "não é um cofre do Obsidian: $vault" >&2; exit 1; }

mkdir -p "$theme_dir" "$config_dir/snippets"
cp "$source_dir/theme.css" "$theme_dir/"
# O Obsidian identifica o tema pelo nome do manifest, que precisa ser igual ao da pasta.
sed "s/\"name\": \"Ardentia\"/\"name\": \"$theme_name\"/" "$repo_dir/manifest.json" > "$theme_dir/manifest.json"
cp "$source_dir"/snippets/*.css "$config_dir/snippets/"

echo "$theme_name instalado em $theme_dir"
echo "Escolha o tema em Configurações, Aparência, Temas."
