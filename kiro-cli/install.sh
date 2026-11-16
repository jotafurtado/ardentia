#!/usr/bin/env bash
# Faz o kiro-cli herdar as cores do terminal: grava as preferências de tema do Ardentia
# na pasta de configurações do kiro-cli.
# Uso: ./kiro-cli/install.sh
#   KIRO_SETTINGS_DIR  pasta de destino, quando não for a padrão
#                      (${KIRO_HOME:-$HOME/.kiro}/settings)
# Não edita arquivo de configuração do shell.
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$source_dir/kiro_cli_theme.json"
settings_dir="${KIRO_SETTINGS_DIR:-${KIRO_HOME:-$HOME/.kiro}/settings}"
target_file="$settings_dir/kiro_cli_theme.json"

[[ -f "$source_file" ]] || { echo "arquivo de preferências não encontrado: $source_file" >&2; exit 1; }

mkdir -p "$settings_dir"

# As preferências que já existem ficam guardadas, quando são diferentes das do porte:
# uma base ou uma predefinição escolhida antes venceria a variável de ambiente.
if [[ -f "$target_file" ]] && ! cmp -s "$source_file" "$target_file"; then
  backup_file="$target_file.bak-$(date +%Y%m%d-%H%M%S)"
  cp "$target_file" "$backup_file"
  echo "Preferências anteriores guardadas em $backup_file"
fi

cp "$source_file" "$target_file"

echo "Preferências de tema do Ardentia gravadas em $target_file"
echo "Para ativar, ponha esta linha no arquivo de configuração do seu shell (~/.zshrc, ~/.bashrc):"
echo "  export KIRO_TERMINAL_THEME=safe"
echo "As cores vêm do terminal: a paleta aparece num terminal com o Ardentia, como o Ghostty e o Rex."
