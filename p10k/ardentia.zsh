# Ardentia para o Powerlevel10k, versão 1.0.0
# O brilho que o mar acende à noite. Tema escuro.
# Autor: Jota Furtado. Licença: MIT.
# https://github.com/jotafurtado/ardentia
#
# Configuração completa do Powerlevel10k. Carregue este arquivo no lugar de ~/.p10k.zsh:
#
#   [[ ! -f ~/.p10k-ardentia.zsh ]] || source ~/.p10k-ardentia.zsh
#
# O prompt tem duas linhas. Na primeira, uma cápsula quieta com a pasta, o Git, o resultado
# do último comando, a duração e as tarefas em segundo plano. Na segunda, o caractere de prompt.
# O fundo não muda de cor: a cor fica no texto, e só onde é sinal.
#
# Precisa de zsh 5.7.1 ou mais novo, de um terminal com truecolor e de uma fonte Nerd Font.
#
# A estrutura e o formatador do Git vêm de config/p10k-classic.zsh, do Powerlevel10k
# (Roman Perepelitsa, licença MIT).
#
# Paleta do Ardentia usada aqui:
#   relevo       #1d2240   fundo da cápsula
#   borda-forte  #3a4273   separador entre os segmentos
#   tenue        #8791c2   o que é contexto: prefixos, trecho encurtado, duração, tarefas
#   mare         #7cb2ff   pasta, arquivos não rastreados
#   mare-clara   #a9ccff   âncora da pasta
#   anemona      #b9a0ff   ramo do Git
#   ardentia     #4de8d8   caractere de prompt, commits à frente e atrás
#   sargaco      #b4ee7c   comando que deu certo, alterações preparadas
#   lanterna     #ffcc70   alterações não preparadas
#   coral        #ff7383   erro, conflito

# Guarda as opções do shell e liga as que este arquivo precisa.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Apaga toda opção de configuração anterior, para o arquivo valer sozinho.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh 5.1 ou mais novo.
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  ####################################[ segmentos ]####################################

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # Linha 1: a cápsula.
    dir                     # pasta atual
    vcs                     # estado do Git
    status                  # resultado do último comando
    command_execution_time  # duração do último comando
    background_jobs         # tarefas em segundo plano
    # Linha 2.
    newline                 # \n
    prompt_char             # caractere de prompt
  )

  # Nada à direita.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  ######################################[ forma ]######################################

  # Conjunto de ícones.
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=none

  # Ícone depois do conteúdo.
  typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=

  # Uma linha em branco antes de cada prompt.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Sem moldura: a cápsula e o caractere de prompt bastam.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=

  # Espaço entre o fim da cápsula e a borda direita do terminal.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=

  # O fundo fica quieto: todo segmento da cápsula em relevo.
  typeset -g POWERLEVEL9K_BACKGROUND='#1d2240'

  # Entre dois segmentos, um separador fino em borda-forte.
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%F{#3a4273}'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%F{#3a4273}'
  # Como o fundo é um só, o separador de fundos diferentes não aparece na cápsula.
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=

  # A cápsula abre e fecha com a ponta arredondada.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

  ##############################[ prompt_char: caractere de prompt ]##############################

  # Sem fundo.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  # Ardentia quando o último comando deu certo, coral quando falhou.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#4de8d8'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#ff7383'
  # Caractere padrão e o do modo de inserção do vi.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  # Modo de comando do vi.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  # Modo visual do vi.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  # Modo de substituição do vi.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  # O caractere de prompt não faz parte da cápsula: sem ponta antes nem depois.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  # Sem espaço extra em volta: o Powerlevel10k já separa o caractere do que se digita.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

  ####################################[ dir: pasta atual ]####################################

  # Pasta em maré.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND='#7cb2ff'
  # Se a pasta for longa demais, encurta os trechos até o menor prefixo único.
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  # Trecho encurtado em tênue.
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='#8791c2'
  # Âncora em maré-clara e negrito. Âncora é o trecho que nunca é encurtado.
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#a9ccff'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  # A pasta que tem um destes arquivos é âncora: é a raiz de um projeto.
  local anchor_files=(
    .bzr
    .citc
    .git
    .hg
    .node-version
    .python-version
    .go-version
    .ruby-version
    .lua-version
    .java-version
    .perl-version
    .php-version
    .tool-versions
    .shorten_folder_marker
    .svn
    .terraform
    CVS
    Cargo.toml
    composer.json
    go.mod
    package.json
    stack.yaml
  )
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
  typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
  # Não encurta o último trecho.
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  # Encurta a pasta quando ela passa disto.
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  # E encurta mais para sobrar este espaço para o comando, em colunas e em porcentagem da largura.
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
  # Mostra um cadeado quando a pasta não aceita escrita.
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
  typeset -g POWERLEVEL9K_DIR_CLASSES=()

  ###################################[ vcs: estado do Git ]###################################

  # Sem ícone de ramo.
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
  # Marca dos arquivos não rastreados.
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

  # Monta o texto do Git. Exemplo: main ⇣42⇡42 *42 merge ~42 +42 !42 ?42.
  # $1 é 1 quando o estado é atual e 0 quando ainda está sendo lido: nesse caso tudo sai em tênue.
  function my_git_formatter() {
    emulate -L zsh

    if [[ -n $P9K_CONTENT ]]; then
      # Fora de um repositório Git, ou com outro sistema de versões, vale o texto que já veio pronto.
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi

    if (( $1 )); then
      local       meta='%F{#8791c2}'  # tênue
      local     branch='%F{#b9a0ff}'  # anêmona
      local     remote='%F{#4de8d8}'  # ardentia
      local     staged='%F{#b4ee7c}'  # sargaço
      local   modified='%F{#ffcc70}'  # lanterna
      local  untracked='%F{#7cb2ff}'  # maré
      local conflicted='%F{#ff7383}'  # coral
    else
      local       meta='%F{#8791c2}'  # tênue
      local     branch='%F{#8791c2}'  # tênue
      local     remote='%F{#8791c2}'  # tênue
      local     staged='%F{#8791c2}'  # tênue
      local   modified='%F{#8791c2}'  # tênue
      local  untracked='%F{#8791c2}'  # tênue
      local conflicted='%F{#8791c2}'  # tênue
    fi

    local res

    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      local name=${(V)VCS_STATUS_LOCAL_BRANCH}
      # Ramo com mais de 32 caracteres mostra os 12 primeiros, … e os 12 últimos.
      (( $#name > 32 )) && name[13,-13]="…"
      res+="${branch}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${name//\%/%%}"
    fi

    # A tag só aparece quando não se está num ramo.
    if [[ -n $VCS_STATUS_TAG && -z $VCS_STATUS_LOCAL_BRANCH ]]; then
      local tag=${(V)VCS_STATUS_TAG}
      (( $#tag > 32 )) && tag[13,-13]="…"
      res+="${meta}#${branch}${tag//\%/%%}"
    fi

    # O commit só aparece quando não há ramo nem tag.
    [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&
      res+="${meta}@${branch}${VCS_STATUS_COMMIT[1,8]}"

    # Ramo remoto, quando o nome é diferente do local.
    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
      res+="${meta}:${branch}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
    fi

    # "wip" quando o último commit se declara em andamento.
    if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
      res+=" ${modified}wip"
    fi

    if (( VCS_STATUS_COMMITS_AHEAD || VCS_STATUS_COMMITS_BEHIND )); then
      # ⇣42 atrás do remoto.
      (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${remote}⇣${VCS_STATUS_COMMITS_BEHIND}"
      # ⇡42 à frente do remoto; sem espaço quando vem logo depois do ⇣42.
      (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
      (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${remote}⇡${VCS_STATUS_COMMITS_AHEAD}"
    fi

    # ⇠42 atrás do remoto de push.
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${remote}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
    # ⇢42 à frente do remoto de push.
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${remote}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    # *42 stashes.
    (( VCS_STATUS_STASHES        )) && res+=" ${meta}*${VCS_STATUS_STASHES}"
    # "merge", "rebase" e semelhantes, quando há uma operação em curso.
    [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
    # ~42 conflitos.
    (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
    # +42 alterações preparadas.
    (( VCS_STATUS_NUM_STAGED     )) && res+=" ${staged}+${VCS_STATUS_NUM_STAGED}"
    # !42 alterações não preparadas.
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
    # ?42 arquivos não rastreados.
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
    # "─" quando não se sabe quantas alterações não preparadas há: o repositório é grande
    # demais ou tem bash.showDirtyState = false.
    (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null

  # Conta as alterações em repositório de qualquer tamanho.
  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1

  # Não mostra o estado do Git na pasta pessoal, onde costuma haver só arquivos de configuração.
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

  # O texto do Git vem do formatador acima.
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  # Com menos de 50 colunas, a pasta mostra só o último trecho, cortado para caber.
  typeset -g POWERLEVEL9K_DIR_CONTENT_EXPANSION='${${${$((_p9k__clm >= 50)):#0}:+${P9K_CONTENT}}:-${${${(%):-%1~}//\%/%%}[1,$((_p9k__clm > 12 ? _p9k__clm - 9 : 3))]}}'
  # Com menos de 80 colunas, o Git some.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+${$((my_git_formatter(1)))+${my_git_format}}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+${$((my_git_formatter(0)))+${my_git_format}}}'
  # Conta todas as alterações, sem teto.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

  # Sem ícone no segmento.
  typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR='#b9a0ff'
  typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR='#8791c2'
  typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=
  # Prefixo em tênue.
  typeset -g POWERLEVEL9K_VCS_PREFIX='%F{#8791c2}on '

  # Só Git.
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

  # Estas cores só valem para outro sistema de versões; no Git quem pinta é o formatador.
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#b9a0ff'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#b9a0ff'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#ffcc70'

  ##############################[ status: resultado do último comando ]##############################

  # Distingue erro simples, sinal e erro num trecho de pipe.
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true

  # Comando que deu certo: só o ícone, em sargaço. Com menos de 80 colunas, some.
  typeset -g POWERLEVEL9K_STATUS_OK=true
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='#b4ee7c'
  typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+✔}'

  # Pipe que deu certo no fim, com erro no meio.
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND='#b4ee7c'
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+✔}'

  # Erro: o código de saída, em coral.
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#ff7383'
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+✘}'

  # Comando encerrado por sinal.
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND='#ff7383'
  # Nome curto do sinal: INT, e não SIGINT(2).
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+✘}'

  # Pipe que falhou.
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND='#ff7383'
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+✘}'

  #######################[ command_execution_time: duração do último comando ]#######################

  # Aparece quando o comando leva 3 segundos ou mais.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  # Sem casas decimais.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  # Duração em tênue.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#8791c2'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  # Sem ícone.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%F{#8791c2}took '
  # Com menos de 80 colunas, some.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_CONTENT_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+$P9K_CONTENT}'

  ##########################[ background_jobs: tarefas em segundo plano ]##########################

  # Só o ícone, sem a contagem.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  # Em tênue.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='#8791c2'
  # Com menos de 80 colunas, some.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='${${$((_p9k__clm >= 80)):#0}:+$P9K_VISUAL_IDENTIFIER}'

  ####################################[ comportamento ]####################################

  # Prompt transitório: ao aceitar um comando, o prompt anterior encolhe para o caractere de prompt.
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

  # Prompt instantâneo: mostra o prompt antes de o zsh terminar de carregar e avisa quando algo
  # escreve na tela durante a carga. Só tem efeito com o bloco do prompt instantâneo no ~/.zshrc.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # Não confere a cada prompt se a configuração mudou. Depois de editar este arquivo,
  # carregue-o de novo com `source`.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # Se o Powerlevel10k já está carregado, aplica a configuração agora.
  (( ! $+functions[p10k] )) || p10k reload
}

# POWERLEVEL9K_CONFIG_FILE fica sem valor de propósito: assim o `p10k configure` grava em
# ~/.p10k.zsh, como de costume, e não por cima deste arquivo.

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
