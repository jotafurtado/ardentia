#!/usr/bin/env bash
# Copia a configuração Ardentia do Powerlevel10k para a pasta do zsh.
# Uso: ./p10k/install.sh
#   P10K_ARDENTIA_FILE  arquivo de destino, quando não for o padrão
#                       (${ZDOTDIR:-$HOME}/.p10k-ardentia.zsh)
# Não edita o ~/.zshrc nem toca no ~/.p10k.zsh.
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_file="$source_dir/ardentia.zsh"
target_file="${P10K_ARDENTIA_FILE:-${ZDOTDIR:-$HOME}/.p10k-ardentia.zsh}"

[[ -f "$source_file" ]] || { echo "arquivo da configuração não encontrado: $source_file" >&2; exit 1; }

# O arquivo entra com nome próprio, para não cobrir a configuração que o assistente
# do Powerlevel10k grava em .p10k.zsh.
if [[ "$(basename "$target_file")" == ".p10k.zsh" ]]; then
  echo "o destino não pode ser .p10k.zsh: escolha outro nome em P10K_ARDENTIA_FILE" >&2
  exit 1
fi

mkdir -p "$(dirname "$target_file")"
cp "$source_file" "$target_file"

# Mostra o caminho com ~ quando ele fica na pasta pessoal.
shown_file="$target_file"
[[ "$target_file" == "$HOME"/* ]] && shown_file="~/${target_file#"$HOME"/}"

echo "Ardentia para o Powerlevel10k instalado em $target_file"
echo "Para ativar, troque no seu ~/.zshrc a linha que carrega o ~/.p10k.zsh por esta:"
echo "  [[ ! -f $shown_file ]] || source $shown_file"
echo "Precisa de zsh 5.7.1 ou mais novo, de um terminal com truecolor e de uma fonte Nerd Font."
