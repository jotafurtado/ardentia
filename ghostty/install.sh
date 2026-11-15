#!/usr/bin/env bash
# Copia o tema Ardentia para a pasta de temas do Ghostty.
# Uso: ./ghostty/install.sh
#   GHOSTTY_THEMES_DIR  pasta de destino, quando não for a padrão
#                       (${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes)
# Não edita o arquivo config do Ghostty nem troca o tema ativo.
set -euo pipefail

theme_name="Ardentia"
source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
themes_dir="${GHOSTTY_THEMES_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes}"

[[ -f "$source_dir/$theme_name" ]] || { echo "arquivo do tema não encontrado: $source_dir/$theme_name" >&2; exit 1; }

mkdir -p "$themes_dir"
cp "$source_dir/$theme_name" "$themes_dir/$theme_name"

echo "$theme_name instalado em $themes_dir/$theme_name"
echo "Para ativar, ponha esta linha na sua configuração do Ghostty:"
echo "  theme = $theme_name"
