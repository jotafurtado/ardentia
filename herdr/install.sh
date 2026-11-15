#!/usr/bin/env bash
# Copia o tema Ardentia para a pasta de temas do app Herdr e mostra onde está
# o trecho para o herdr de terminal.
# Uso: ./herdr/install.sh
#   HERDR_APP_HOME  pasta de configuração do app, quando não for a padrão
#                   (${XDG_CONFIG_HOME:-$HOME/.config}/herdr-app)
# Não cria, não lê e não edita nenhum config.toml, e não troca o tema ativo.
set -euo pipefail

theme_name="ardentia"
theme_file="$theme_name.json"
snippet_file="$theme_name.toml"
source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# A mesma ordem que o app segue: HERDR_APP_HOME, depois XDG_CONFIG_HOME, depois ~/.config.
app_home="${HERDR_APP_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/herdr-app}"
themes_dir="$app_home/themes"

[[ -f "$source_dir/$theme_file" ]] || { echo "arquivo do tema não encontrado: $source_dir/$theme_file" >&2; exit 1; }

mkdir -p "$themes_dir"
cp "$source_dir/$theme_file" "$themes_dir/$theme_file"

echo "Ardentia instalado em $themes_dir/$theme_file"
echo "Para aplicar no app Herdr, escolha $theme_name em Settings, Look, Theme, ou rode:"
echo "  herdr-app do app.theme --name $theme_name"
echo
# O herdr de terminal não lê arquivo de tema: o trecho é colado à mão no config.toml.
echo "O herdr de terminal não tem arquivo de tema. O trecho para ele está em:"
echo "  $source_dir/$snippet_file"
echo "Cole esse trecho no seu config.toml (em Linux e macOS, ~/.config/herdr/config.toml)."
echo "Este script não toca no config.toml."
