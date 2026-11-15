#!/usr/bin/env bash
# Copia a status line para a pasta de configuração do Claude Code.
# Uso: ./cc-statusline/install.sh
#   CLAUDE_CONFIG_DIR  pasta de configuração do Claude Code, quando não for a padrão (~/.claude)
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$source_dir/statusline.sh"
config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
target_file="$config_dir/ardentia-statusline.sh"

[[ -f "$source_file" ]] || { echo "arquivo da status line não encontrado: $source_file" >&2; exit 1; }

# O arquivo entra com nome próprio, para não cobrir um statusline.sh que já exista.
# O settings.json fica como está: a linha que ativa a status line é mostrada abaixo.
mkdir -p "$config_dir"
cp "$source_file" "$target_file"
chmod +x "$target_file"

echo "Status line do Ardentia instalada em $target_file"
echo "Para ativar, ponha este trecho no settings.json do Claude Code ($config_dir/settings.json):"
echo '  "statusLine": { "type": "command", "command": "'"$target_file"'" }'
echo "Ela precisa de jq, de git e de uma fonte com glifos Nerd Font no terminal."
