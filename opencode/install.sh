#!/usr/bin/env bash
# Copia o tema Ardentia do OpenCode para a pasta de temas do OpenCode.
# Uso: ./opencode/install.sh
#   OPENCODE_THEMES_DIR  pasta de destino, quando não for a padrão
#                        (${XDG_CONFIG_HOME:-~/.config}/opencode/themes)
# Guarda uma cópia de um ardentia.json diferente que já exista. Não edita o cli.json,
# o opencode.json nem o ~/.zshrc.
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$source_dir/ardentia.json"

[[ -f "$source_file" ]] || { echo "arquivo do tema não encontrado: $source_file" >&2; exit 1; }

target_dir="${OPENCODE_THEMES_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode/themes}"
target_file="$target_dir/ardentia.json"

mkdir -p "$target_dir"

if [[ -f "$target_file" ]] && cmp -s "$source_file" "$target_file"; then
  echo "Ardentia para o OpenCode já está em $target_file"
else
  if [[ -f "$target_file" ]]; then
    backup_file="$target_file.bak-$(date +%Y%m%d)"
    # Uma segunda cópia no mesmo dia não cobre a primeira.
    if [[ -e "$backup_file" ]]; then
      backup_file="$target_file.bak-$(date +%Y%m%d-%H%M%S)"
    fi
    cp "$target_file" "$backup_file"
    echo "O ardentia.json que existia foi guardado em $backup_file"
  fi
  cp "$source_file" "$target_file"
  echo "Ardentia para o OpenCode instalado em $target_file"
fi

echo "Para ativar, ponha no ~/.config/opencode/cli.json:"
echo '  "theme": { "name": "ardentia", "mode": "dark" }'
echo "Ou abra o OpenCode, Ctrl+P, Open settings, Theme, e escolha ardentia."
echo "O tema só tem modo escuro. Precisa de um terminal com truecolor."
