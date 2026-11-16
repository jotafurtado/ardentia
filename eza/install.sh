#!/usr/bin/env bash
# Copia o tema Ardentia do eza para a pasta de configuração que o eza lê.
# Uso: ./eza/install.sh
#   EZA_CONFIG_DIR  pasta de destino, quando não for a padrão do sistema:
#                   macOS: ~/Library/Application Support/eza
#                   Linux: ${XDG_CONFIG_HOME:-~/.config}/eza
# Guarda uma cópia de um theme.yml diferente que já exista. Não edita o ~/.zshrc.
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$source_dir/theme.yml"

[[ -f "$source_file" ]] || { echo "arquivo do tema não encontrado: $source_file" >&2; exit 1; }

if [[ -n "${EZA_CONFIG_DIR:-}" ]]; then
  target_dir="$EZA_CONFIG_DIR"
elif [[ "$(uname -s)" == "Darwin" ]]; then
  # No macOS o eza não lê ~/.config nem XDG_CONFIG_HOME.
  target_dir="$HOME/Library/Application Support/eza"
else
  target_dir="${XDG_CONFIG_HOME:-$HOME/.config}/eza"
fi
target_file="$target_dir/theme.yml"

mkdir -p "$target_dir"

if [[ -f "$target_file" ]] && cmp -s "$source_file" "$target_file"; then
  echo "Ardentia para o eza já está em $target_file"
  exit 0
fi

if [[ -f "$target_file" ]]; then
  backup_file="$target_file.bak-$(date +%Y%m%d)"
  # Uma segunda cópia no mesmo dia não cobre a primeira.
  if [[ -e "$backup_file" ]]; then
    backup_file="$target_file.bak-$(date +%Y%m%d-%H%M%S)"
  fi
  cp "$target_file" "$backup_file"
  echo "O theme.yml que existia foi guardado em $backup_file"
fi

cp "$source_file" "$target_file"

echo "Ardentia para o eza instalado em $target_file"
echo "O eza usa o tema sem flag. Se a variável EZA_COLORS estiver definida, as chaves dela vencem as do tema."
echo "Precisa de um terminal com truecolor."
