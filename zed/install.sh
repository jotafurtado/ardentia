#!/usr/bin/env bash
# Copia o tema para a pasta de temas locais do Zed.
# Uso: ./zed/install.sh
#   ZED_THEMES_DIR  pasta de destino, quando não for a padrão (~/.config/zed/themes)
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
theme_file="$source_dir/themes/ardentia.json"

# No macOS o Zed lê sempre ~/.config/zed e ignora XDG_CONFIG_HOME. No Linux ele segue a variável.
if [[ "$(uname -s)" == "Darwin" ]]; then
  default_dir="$HOME/.config/zed/themes"
else
  default_dir="${XDG_CONFIG_HOME:-$HOME/.config}/zed/themes"
fi
themes_dir="${ZED_THEMES_DIR:-$default_dir}"

[[ -f "$theme_file" ]] || { echo "arquivo do tema não encontrado: $theme_file" >&2; exit 1; }

# Só o arquivo do tema é copiado. O settings.json do Zed e o tema ativo ficam como estão.
mkdir -p "$themes_dir"
cp "$theme_file" "$themes_dir/"

echo "Ardentia instalado em $themes_dir/ardentia.json"
echo "O tema aparece no seletor na próxima vez que o Zed carregar."
echo "Abra o seletor de temas pela paleta de comandos (ação theme_selector::Toggle) e escolha Ardentia."
