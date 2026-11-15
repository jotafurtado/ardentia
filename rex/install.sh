#!/usr/bin/env bash
# Importa o tema Ardentia no Rex pelo CLI e, se o Rex não aceitar ações,
# mostra o caminho do arquivo e os passos pela interface.
# Uso: ./rex/install.sh
#   REX_CLIENT  rótulo ou ID do app Rex, quando houver mais de um conectado
# Não liga o Remote Control, não troca o tema ativo e não edita o init.lua.
# O Rex guarda tema importado nas próprias preferências, sem pasta de temas:
# importar duas vezes pode duplicar a entrada.
set -euo pipefail

theme_name="Ardentia"
source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
theme_path="$source_dir/$theme_name"

[[ -f "$theme_path" ]] || { echo "arquivo do tema não encontrado: $theme_path" >&2; exit 1; }

manual_steps() {
  echo "Para importar pela interface do Rex:"
  echo "  1. Abra Settings, Themes, Import Theme e escolha $theme_path"
  echo "  2. Em Settings, Themes, Dark Mode, selecione $theme_name"
}

if ! command -v rex >/dev/null 2>&1; then
  echo "O CLI do rex não foi encontrado."
  manual_steps
  exit 0
fi

client_args=()
[[ -n "${REX_CLIENT:-}" ]] && client_args=(-C "$REX_CLIENT")

if output="$(rex ${client_args[@]+"${client_args[@]}"} do client.theme.import path="$theme_path" 2>&1)"; then
  echo "$theme_name importado no Rex."
  echo "Para ativar, escolha $theme_name em Settings, Themes, Dark Mode, ou rode:"
  echo "  rex do client.theme.change name=$theme_name"
else
  echo "O Rex não importou o tema: $output"
  echo "Se for o Remote Control desligado, ligue em Settings, Rex Server, ou importe à mão."
  manual_steps
fi
