# Ardentia para o herdr

<a href="README.md">English</a> · <b>Português</b>

Referência do porte para o herdr. A visão geral, a paleta e os princípios estão no [README principal](../README.pt-BR.md). O tema do app foi escrito contra o repositório do app Herdr no commit `d0c8daf` (versão 0.1.15). O bloco do terminal foi escrito contra o herdr 0.9.5 e passa no `herdr config check`. Nenhum dos dois foi revisado em janela aberta.

## Dois produtos, dois arquivos

Dois produtos atendem pelo nome herdr, e cada um recebe um arquivo diferente.

- **O app desktop Herdr** lê temas em `themes/<nome>.json`, dentro da pasta de configuração dele. Usa o `ardentia.json`.
- **O herdr de terminal** (o binário `herdr`) não tem arquivo de tema. Aceita uma tabela `[theme]` no `config.toml`, com uma tabela `[theme.custom]` que sobrepõe 19 tokens de cor a um tema embutido. Usa o `ardentia.toml`.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `ardentia.json` | O tema do app desktop Herdr: cores do terminal, as 16 cores ANSI e as cores dos painéis |
| `ardentia.toml` | O bloco para colar no `config.toml` do herdr de terminal: um tema de base e os 19 tokens |
| `install.sh` | Copia o `ardentia.json` para a pasta de temas do app e mostra onde está o `ardentia.toml` |

## App Herdr

### Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/herdr/install.sh
```

O script copia o `ardentia.json` para a pasta `themes` da pasta de configuração do app: `$HERDR_APP_HOME` quando está definida, senão `$XDG_CONFIG_HOME/herdr-app`, senão `~/.config/herdr-app`. É a mesma ordem que o app segue. Ele cria a pasta se ela faltar e mostra onde o arquivo ficou. Para mandar o tema para outro lugar, defina `HERDR_APP_HOME`:

```bash
HERDR_APP_HOME="/caminho/do/herdr-app" ./ardentia/herdr/install.sh
```

O script não troca o tema ativo. Para o herdr de terminal ele só mostra o caminho do `ardentia.toml`: não cria, não lê e não edita nenhum `config.toml`.

### Instalar à mão

Copie o `ardentia.json` desta pasta para `~/.config/herdr-app/themes/`. Mantenha o nome do arquivo: é por ele que o app chama o tema.

```bash
mkdir -p ~/.config/herdr-app/themes
cp ardentia/herdr/ardentia.json ~/.config/herdr-app/themes/
```

### Aplicar

No app, abra Settings, Look, e escolha `ardentia` em Theme, no grupo Dark. Ou rode o comando `app.theme` contra a janela aberta:

```bash
herdr-app do app.theme --name ardentia
```

O app lista o tema pelo nome do arquivo, por isso o Ardentia aparece em minúsculas.

## herdr de terminal

### Usar o bloco

1. Abra o seu `config.toml`. Em Linux e macOS é `~/.config/herdr/config.toml`, no Windows `%APPDATA%\herdr\config.toml`. O `herdr --help` mostra o caminho em uso.
2. Cole o conteúdo do `ardentia.toml` no fim do arquivo. Se o arquivo já tem uma tabela `[theme]` ou `[theme.custom]`, apague-a antes: tabela repetida é erro de TOML.
3. Valide o arquivo:

   ```bash
   herdr config check
   ```

4. Recarregue a configuração, com o comando abaixo ou com `reload config` no menu global do herdr:

   ```bash
   herdr server reload-config
   ```

A documentação do herdr diz que o tema vem da configuração local do cliente, e que a ação do menu recarrega tanto as configurações do cliente quanto a configuração do servidor.

### Cores dentro dos painéis

O bloco pinta a interface do próprio herdr: barra lateral, faixa de abas, painéis flutuantes, separadores. Ele não define as 16 cores ANSI, o fundo nem o texto padrão dos programas que rodam nos painéis. Essas cores vêm do terminal hospedeiro. O par natural é o porte para o Ghostty, em [`../ghostty/`](../ghostty/), que dá aos painéis o fundo Nota e as mesmas 16 cores listadas abaixo.

## Mapa de cores do tema do app

As chaves de base, que pintam os terminais:

| Chave | Cor do Ardentia | Hex | Uso |
| --- | --- | --- | --- |
| `background` | Nota | `#161a30` | fundo do terminal, preenchimento dos campos de texto nos painéis |
| `foreground` | Texto | `#dde2fa` | texto do terminal |
| `selection` | Ardentia a 24% sobre Nota | `#234b58` | seleção |
| `cursor` | Ardentia | `#4de8d8` | cursor |

As chaves de `colors`, que pintam os painéis:

| Chave | Cor do Ardentia | Hex | Uso |
| --- | --- | --- | --- |
| `canvas` | Abismo | `#0b0d1a` | atrás dos cartões dos painéis |
| `chrome` | Fundo | `#101326` | barra lateral, faixa de abas, barra de status |
| `surface` | Nota | `#161a30` | cartões e prévias |
| `popover` | Fundo | `#101326` | menus, paleta de comandos, diálogos, barra de busca |
| `raised` | Relevo | `#1d2240` | aba ativa, botão secundário |
| `hover` | Relevo | `#1d2240` | item sob o ponteiro |
| `selected` | Relevo | `#1d2240` | linha selecionada: espaço ativo, agente em foco, item atual do menu |
| `border` | Borda | `#272d52` | divisores, contorno dos painéis |
| `input` | Borda forte | `#3a4273` | contorno de campos de texto e de botões secundários, alternador desligado |
| `ring` | Suave | `#a8b0db` | contorno em hover de uma opção da tela de boas-vindas |
| `foreground` | Texto | `#dde2fa` | texto da interface |
| `muted` | Suave | `#a8b0db` | rótulos, abas inativas, barra de status |
| `dim` | Tênue | `#8791c2` | descrições, dicas, ícones em repouso |
| `accent` | Ardentia | `#4de8d8` | contorno do painel e do campo em foco, alternador ligado |
| `accent_foreground` | Abismo | `#0b0d1a` | texto e botão do alternador sobre o acento |
| `solid` | Ardentia | `#4de8d8` | botão primário |
| `solid_foreground` | Abismo | `#0b0d1a` | texto do botão primário |
| `working` | Lanterna | `#ffcc70` | indicador giratório do agente em trabalho |
| `blocked` | Coral | `#ff7383` | selo "Needs you", texto de aviso e de erro |
| `done` | Maré | `#7cb2ff` | marca do agente que concluiu |
| `idle` | Tênue | `#8791c2` | anel do agente ocioso |
| `unknown` | Base-40 | `#4a5388` | ponto do espaço sem estado de agente, na barra lateral recolhida |

## As 16 cores

São a lista `ansi` do `ardentia.json`, nesta ordem.

| Índice | Nome ANSI | Cor do Ardentia | Hex |
| --- | --- | --- | --- |
| 0 | black | Relevo | `#1d2240` |
| 1 | red | Coral | `#ff7383` |
| 2 | green | Sargaço | `#b4ee7c` |
| 3 | yellow | Lanterna | `#ffcc70` |
| 4 | blue | Maré | `#7cb2ff` |
| 5 | magenta | Anêmona | `#b9a0ff` |
| 6 | cyan | Ardentia | `#4de8d8` |
| 7 | white | Suave | `#a8b0db` |
| 8 | bright black | Tênue | `#8791c2` |
| 9 | bright red | Coral | `#ff7383` |
| 10 | bright green | Sargaço | `#b4ee7c` |
| 11 | bright yellow | Lanterna clara | `#ffe2a8` |
| 12 | bright blue | Maré clara | `#a9ccff` |
| 13 | bright magenta | Água-viva | `#ff7ac6` |
| 14 | bright cyan | Ardentia clara | `#8ff5ea` |
| 15 | bright white | Texto | `#dde2fa` |

## Mapa de cores do bloco do terminal

O tema de base é o `tokyo-night`. Os 19 tokens abaixo são a paleta inteira do herdr 0.9.5, então nada da base aparece.

| Token | Cor do Ardentia | Hex | Uso |
| --- | --- | --- | --- |
| `accent` | Ardentia | `#4de8d8` | destaques, contorno do painel ativo, aba em foco |
| `panel_bg` | Fundo | `#101326` | faixa de abas, painéis flutuantes, sobreposições, modais |
| `sidebar_bg` | Fundo | `#101326` | barra lateral |
| `active_row_bg` | Relevo | `#1d2240` | linha do espaço ativo e do agente em foco |
| `selection_bg` | Borda | `#272d52` | linha do cursor no modo Navigate |
| `surface0` | Relevo | `#1d2240` | item selecionado ou em foco, abas fora de foco |
| `surface1` | Borda | `#272d52` | um degrau mais claro, como a linha que está sendo arrastada |
| `surface_dim` | Borda | `#272d52` | separadores, trilho da rolagem do painel fora de foco |
| `overlay0` | Tênue | `#8791c2` | texto secundário, rótulos das abas fora de foco, dicas |
| `overlay1` | Suave | `#a8b0db` | texto de apoio um degrau mais forte |
| `subtext0` | Suave | `#a8b0db` | nomes dos espaços fora de foco, rótulos |
| `text` | Texto | `#dde2fa` | texto principal |
| `mauve` | Anêmona | `#b9a0ff` | nome do ramo |
| `green` | Sargaço | `#b4ee7c` | agente ocioso, conectado, instalado |
| `yellow` | Lanterna | `#ffcc70` | agente em trabalho, conectando |
| `red` | Coral | `#ff7383` | agente bloqueado, pedido de atenção, confirmação antes de remover ou fechar |
| `blue` | Maré | `#7cb2ff` | notificação de trabalho concluído, agente que concluiu na visão compacta |
| `teal` | Ardentia | `#4de8d8` | agente que concluiu, na barra lateral |
| `peach` | Estrela | `#ffa26b` | estados de interrupção e de aviso, segundo um comentário do código-fonte |

## Notas do porte

Os dois arquivos:

- Toda cor é uma das cores da paleta, menos a seleção do `ardentia.json`. Nenhum dos dois formatos é usado com alfa aqui, então a seleção é a mistura já calculada, Ardentia a 24% sobre Nota, que dá `#234b58`. É a mesma seleção que os portes para o Obsidian e para o Ghostty desenham.
- O fundo do terminal é Nota, a superfície contra a qual os contrastes do README principal foram medidos.
- Os dois produtos nomeiam os estados dos agentes de jeitos diferentes. O app nomeia o estado (`working`, `blocked`, `done`, `idle`); o herdr de terminal nomeia o matiz (`yellow`, `red`, `teal`, `green`) e decide sozinho que matiz cada estado leva. No app, `working`, `blocked` e `done` são Lanterna, Coral e Maré. No terminal, o agente em trabalho é Lanterna e o bloqueado é Coral, e o que concluiu é Ardentia na barra lateral e Maré na visão compacta e nas notificações. O agente ocioso é Tênue no app e Sargaço no terminal.

O tema do app:

- O arquivo define todas as cores de painel. Sem `colors` o app deriva essas cores misturando o fundo do terminal com branco ou preto e desenha o texto da interface num quase branco fixo, tudo fora da paleta.
- O arquivo aceita só `background`, `foreground`, `selection`, `cursor`, `ansi` e `colors`. O app recusa qualquer outra chave, então não há nome, autor nem versão dentro dele.
- `canvas` é Abismo e os painéis são cartões em Nota sobre ele, como as ilhas do porte para o Obsidian.
- `muted` é Suave e `dim` é Tênue. Nos painéis do app, `dim` é texto corrido: descrições em Settings, caminhos de pasta, dicas. Base-40 mede 2,5:1 sobre Fundo e não seria legível ali. Tênue mede 6,0:1.
- `input` é o contorno dos campos de texto, não o preenchimento. Os painéis preenchem o campo com `background`. A mesma chave desenha o trilho do alternador desligado e as linhas de árvore da lista de agentes, que ficam sobre linhas em `raised`. Nas cores que o app deriva, `input` é mais forte que `border`, então aqui ela é Borda forte, um degrau acima de Borda.
- `selected` é Relevo, a mesma cor de `hover`, como o item selecionado de lista nos portes para Zed e VS Code. Sobre Borda, o texto em `dim` mediria 4,3:1.
- `working`, `blocked` e `done` são Lanterna, Coral e Maré. Seguem o que o app faz sozinho com um tema sem `colors`: o amarelo, o vermelho e o azul das 16 cores. Os painéis do app reaproveitam `blocked` para texto de aviso e de erro, que por isso aparece em Coral.
- `unknown` pinta o ponto do espaço em que nenhum agente informa estado. Não é erro, então é Base-40, a cor do que deve quase sumir.
- `ring` não está na lista de nomes que o app documenta para `theme()`, mas o app a resolve, e o tema `win98` que vem com o app a define. Sem ela o app deriva um cinza fora da paleta, então o arquivo a define em Suave.
- O preto (black), a primeira das 16 cores, é Relevo, quase a cor do fundo. Serve de fundo e de texto sobre fundo colorido. Um programa que escreve em preto sobre o fundo padrão fica ilegível.
- O formato não tem chave para o texto sob o cursor nem para o texto selecionado.
- As `colors` do próprio layout e as `colors` do `settings.json` do app vencem as do tema. O layout Terminals que vem com o app define as dele, então nele o Ardentia aparece só em parte.
- Os valores são `#rrggbb`. Os painéis do app acrescentam dois dígitos de alfa a alguns deles, como `blocked` e `accent`, para desenhar preenchimentos translúcidos, o que só funciona com seis dígitos.

O bloco do terminal:

- O herdr de terminal não tem arquivo de tema nem pasta de temas. Um tema é um nome embutido mais sobreposições, então o porte é um bloco para colar e não um arquivo para instalar.
- Os tokens foram lidos no herdr 0.9.5: a lista na referência de configuração, e o que cada um pinta no código-fonte da tag `v0.9.5`. Uma versão mais nova pode acrescentar ou renomear tokens. Um token acrescentado depois levaria a cor do tema de base, e por isso a base é o `tokyo-night`, o tema embutido mais próximo dos azuis escuros do Ardentia.
- No herdr 0.9.5, o `herdr config check` acusa nome de tema desconhecido e token desconhecido. Num teste, ele não acusou valor de cor inválido.
- `panel_bg` e `sidebar_bg` são Fundo, a cor das barras laterais e das faixas de abas em todos os portes. Com o terminal hospedeiro em Nota, os painéis ficam um degrau mais claros que a interface em volta.
- `overlay0` é o texto secundário de toda a interface, inclusive os rótulos das abas fora de foco, então é Tênue: 5,1:1 sobre Relevo e 6,0:1 sobre Fundo. Sobre a linha do cursor do modo Navigate, em Borda, o mesmo texto mede 4,3:1. O mesmo token desenha o contorno do painel fora de foco, que por isso fica mais claro que Borda.
- `peach` pode ser definido, mas nada no código-fonte do 0.9.5 pinta com ele.
- `surface_dim` é desenhado como a linha dos separadores e como o trilho da rolagem, sobre a barra lateral e os painéis. É Borda para as linhas continuarem visíveis sobre Fundo.
- Os tokens de matiz levam a luz do mesmo matiz. `teal` e `accent` são ambos Ardentia.
- A seleção de texto dentro de um painel não é um token. O herdr a calcula a partir do fundo do terminal hospedeiro, então ela não é `#234b58`.
