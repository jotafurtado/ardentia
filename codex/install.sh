#!/usr/bin/env bash
# Copia o tema Ardentia do Codex para a pasta de temas do Codex.
# Uso: ./codex/install.sh
#   CODEX_HOME  pasta de configuração do Codex, quando não for a padrão (~/.codex)
# Guarda uma cópia de um ardentia.tmTheme diferente que já exista. Não edita o config.toml.
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$source_dir/ardentia.tmTheme"

[[ -f "$source_file" ]] || { echo "arquivo do tema não encontrado: $source_file" >&2; exit 1; }

target_dir="${CODEX_HOME:-$HOME/.codex}/themes"
target_file="$target_dir/ardentia.tmTheme"

mkdir -p "$target_dir"

if [[ -f "$target_file" ]] && cmp -s "$source_file" "$target_file"; then
  echo "Ardentia para o Codex já está em $target_file"
else
  if [[ -f "$target_file" ]]; then
    backup_file="$target_file.bak-$(date +%Y%m%d)"
    # Uma segunda cópia no mesmo dia não cobre a primeira.
    if [[ -e "$backup_file" ]]; then
      backup_file="$target_file.bak-$(date +%Y%m%d-%H%M%S)"
    fi
    cp "$target_file" "$backup_file"
    echo "O ardentia.tmTheme que existia foi guardado em $backup_file"
  fi
  cp "$source_file" "$target_file"
  echo "Ardentia para o Codex instalado em $target_file"
fi

echo "Para ativar, ponha no ~/.codex/config.toml:"
echo '  [tui]'
echo '  theme = "ardentia"'
echo "Ou abra o Codex, digite /theme e escolha ardentia."
