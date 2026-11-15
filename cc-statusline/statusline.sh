#!/bin/bash
# Ardentia para a status line do Claude Code, versão 1.0.0
# O brilho que o mar acende à noite. Tema escuro.
# Autor: Jota Furtado. Licença: MIT.
# https://github.com/jotafurtado/ardentia
#
# Lê o JSON que o Claude Code manda na entrada padrão e imprime uma linha em segmentos:
# pasta, ramo do Git, arquivos e linhas alteradas, modelo, contexto e nome da sessão.
# Precisa de jq, de git e de uma fonte com glifos Nerd Font.

# O Claude Code chama a status line várias vezes a cada atualização. Sem isto, o
# `git status` abaixo tentaria atualizar o cache do índice e disputaria o
# .git/index.lock com os comandos git de quem está trabalhando.
export GIT_OPTIONAL_LOCKS=0

input=$(cat)
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
CAP_LEFT=$(printf '\xee\x82\xb6')
CAP_RIGHT=$(printf '\xee\x82\xb4')
SEPARATOR=$(printf '\xee\x82\xb1')
ICON_PLUS=$(printf '\xef\x81\x95')
ICON_MINUS=$(printf '\xef\x81\x96')
ICON_SONNET=$(printf '\xee\xb8\xb4')
ICON_OPUS=$(printf '\xee\xba\x99')
ICON_HAIKU=$(printf '\xee\x9f\x95')
ICON_FABLE=$(printf '\xee\xbc\x81')
ICON_GIT=$(printf '\xee\x82\xa0')
ICON_DIFF=$(printf '\xf3\xb0\xa6\x93')

# Paleta do Ardentia, em trincas RGB.
RELEVO="29;34;64"
BORDA_FORTE="58;66;115"
TENUE="135;145;194"
ARDENTIA="77;232;216"
ANEMONA="185;160;255"
MARE="124;178;255"
SARGACO="180;238;124"
LANTERNA="255;204;112"
CORAL="255;115;131"

# O fundo fica quieto: uma cápsula em relevo. A cor vai no texto, e só onde é sinal.
BG="$RELEVO"

if [ "$current_dir" = "$HOME" ]; then
  dir_display="~"
else
  if [[ "$current_dir" == "$HOME"/* ]]; then
    rel_path="${current_dir#$HOME/}"
    depth=$(echo "$rel_path" | tr -cd '/' | wc -c | tr -d ' ')
    if [ "$depth" -gt 0 ]; then
      dir_display="…/$(basename "$current_dir")"
    else
      dir_display="$(basename "$current_dir")"
    fi
  else
    dir_display="$(basename "$current_dir")"
  fi
fi

git_branch=""
git_changes="0"
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
  git_root=$(git -C "$current_dir" rev-parse --show-toplevel 2>/dev/null)
  git_branch=$(git -C "$git_root" symbolic-ref --short HEAD 2>/dev/null || git -C "$git_root" rev-parse --short HEAD 2>/dev/null)
  git_changes=$(git -C "$git_root" status --short --untracked-files=all 2>/dev/null | wc -l | tr -d ' ')
fi

model_display=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
model_id=$(echo "$input" | jq -r '.model.id // ""')
effort_level=$(echo "$input" | jq -r '.effort.level // empty')

if echo "$model_display $model_id" | grep -qi "haiku"; then
  model_icon="$ICON_HAIKU"
elif echo "$model_display $model_id" | grep -qi "opus"; then
  model_icon="$ICON_OPUS"
elif echo "$model_display $model_id" | grep -qi "fable"; then
  model_icon="$ICON_FABLE"
else
  model_icon="$ICON_SONNET"
fi

# 91297 -> 91k, 1000000 -> 1M, 1500000 -> 1.5M
format_tokens() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000) { v = n / 1000000; if (v == int(v)) printf "%dM", v; else printf "%.1fM", v }
    else if (n >= 1000) printf "%dk", n / 1000;
    else printf "%d", n;
  }'
}

context_display=""
context_color="$SARGACO"
context_data=$(echo "$input" | jq '.context_window.current_usage')
if [ "$context_data" != "null" ]; then
  input_tokens=$(echo "$context_data" | jq '.input_tokens // 0')
  cache_creation=$(echo "$context_data" | jq '.cache_creation_input_tokens // 0')
  cache_read=$(echo "$context_data" | jq '.cache_read_input_tokens // 0')
  context_size=$(echo "$input" | jq '.context_window.context_window_size // 200000')

  current_usage=$((input_tokens + cache_creation + cache_read))
  percentage=$((current_usage * 100 / context_size))

  # O contexto avisa pela cor: sargaço enquanto há folga, lanterna na metade, coral perto do fim.
  if [ $percentage -ge 75 ]; then
    context_icon=$(printf '\xee\xb4\xaf')
    context_color="$CORAL"
  elif [ $percentage -ge 50 ]; then
    context_icon=$(printf '\xef\x83\xa4')
    context_color="$LANTERNA"
  elif [ $percentage -ge 25 ]; then
    context_icon=$(printf '\xee\xba\xb2')
  else
    context_icon=$(printf '\xee\xba\xb3')
  fi
  context_display="$context_icon $(format_tokens "$current_usage")/$(format_tokens "$context_size") (${percentage}%)"
fi

lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
session_name=$(echo "$input" | jq -r '.session_name // empty')
if [ ${#session_name} -gt 40 ]; then
  session_name="${session_name:0:39}…"
fi

# Texto na cor pedida, sobre o fundo da cápsula.
paint() {
  printf "\033[38;2;%sm\033[48;2;${BG}m%b\033[0m" "$1" "$2"
}

# Um espaço com o fundo da cápsula.
gap() {
  printf "\033[48;2;${BG}m \033[0m"
}

# O primeiro segmento abre a cápsula com a ponta arredondada. Os demais abrem com o separador.
capsule_open=""
open_segment() {
  if [ -z "$capsule_open" ]; then
    printf "\033[38;2;${BG}m${CAP_LEFT}\033[0m"
    capsule_open="1"
  else
    paint "$BORDA_FORTE" "$SEPARATOR"
  fi
}

open_segment
paint "$MARE" " $dir_display "

if [ -n "$git_branch" ]; then
  open_segment
  paint "$ANEMONA" " $ICON_GIT $git_branch "
fi

# Alterações: a cor só entra quando há o que mostrar. Zero fica em tênue.
added_color="$TENUE"
[ "$lines_added" != "0" ] && added_color="$SARGACO"
removed_color="$TENUE"
[ "$lines_removed" != "0" ] && removed_color="$CORAL"
open_segment
gap
[ "$git_changes" != "0" ] && paint "$LANTERNA" "$ICON_DIFF $git_changes "
paint "$added_color" "$ICON_PLUS $lines_added "
paint "$removed_color" "$ICON_MINUS $lines_removed "

effort_icon=""
case "$effort_level" in
  low) effort_icon=$(printf '\xf3\xb0\xaa\x9f') ;;
  medium) effort_icon=$(printf '\xf3\xb0\xaa\xa1') ;;
  high) effort_icon=$(printf '\xf3\xb0\xaa\xa3') ;;
  xhigh) effort_icon=$(printf '\xef\x81\xad') ;;
  max) effort_icon=$(printf '\xef\x84\xb5') ;;
  ""|auto) effort_icon=$(printf '\xf3\xb0\x81\xa8') ;;
esac
open_segment
paint "$ARDENTIA" " $model_icon $model_display"
[ -n "$effort_icon" ] && paint "$ARDENTIA" " $effort_icon"
gap

if [ -n "$context_display" ]; then
  open_segment
  paint "$context_color" " $context_display "
fi

if [ -n "$session_name" ]; then
  open_segment
  paint "$TENUE" " $session_name "
fi

# A cápsula fecha com a ponta arredondada.
printf "\033[38;2;${BG}m${CAP_RIGHT}\033[0m\n"
