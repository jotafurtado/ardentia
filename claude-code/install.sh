#!/usr/bin/env bash
# Copia o tema Ardentia do Claude Code para a pasta de temas que o Claude Code lê.
# Uso: ./claude-code/install.sh
#   CLAUDE_CONFIG_DIR  pasta de configuração do Claude Code, quando não for ~/.claude
# Guarda uma cópia de um ardentia.json diferente que já exista. Não edita o settings.json.
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$source_dir/ardentia.json"

[[ -f "$source_file" ]] || { echo "arquivo do tema não encontrado: $source_file" >&2; exit 1; }

if [[ -n "${CLAUDE_CONFIG_DIR:-}" ]]; then
  target_dir="$CLAUDE_CONFIG_DIR/themes"
else
  target_dir="$HOME/.claude/themes"
fi
target_file="$target_dir/ardentia.json"

mkdir -p "$target_dir"

if [[ -f "$target_file" ]] && cmp -s "$source_file" "$target_file"; then
  echo "Ardentia para o Claude Code já está em $target_file"
  exit 0
fi

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

echo "Ardentia para o Claude Code instalado em $target_file"
echo "Para ativar, escolha Ardentia em /theme, ou ponha \"theme\": \"custom:ardentia\" no settings.json."
echo "O tema herda as 16 cores do terminal: use um terminal com o Ardentia e com truecolor."
