# Ardentia para o Ghostty

<a href="README.md">English</a> · <b>Português</b>

Referência do porte para o Ghostty. A visão geral, a paleta e os princípios estão no [README principal](../README.pt-BR.md). Validado pela linha de comando do Ghostty 1.4.0 (`+validate-config` e `+show-config`). Não foi revisado em janela aberta.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `Ardentia` | O tema. Um arquivo de configuração do Ghostty, sem extensão, só com chaves de cor |
| `install.sh` | Copia o tema para a pasta de temas do Ghostty |

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/ghostty/install.sh
```

O script copia `Ardentia` para `$XDG_CONFIG_HOME/ghostty/themes`, ou para `~/.config/ghostty/themes` quando `XDG_CONFIG_HOME` não está definida. Ele cria a pasta se ela faltar e mostra onde o arquivo ficou. Para mandar o tema a outro lugar, defina `GHOSTTY_THEMES_DIR`:

```bash
GHOSTTY_THEMES_DIR="/caminho/dos/temas" ./ardentia/ghostty/install.sh
```

O script não edita o seu arquivo `config` do Ghostty e não troca o tema ativo.

## Instalar à mão

Copie o arquivo `Ardentia` desta pasta para `~/.config/ghostty/themes/`. Mantenha o nome como está, sem extensão: o nome do arquivo é o nome do tema.

```bash
mkdir -p ~/.config/ghostty/themes
cp ardentia/ghostty/Ardentia ~/.config/ghostty/themes/
```

## Ativar

Ponha esta linha na sua configuração do Ghostty:

```
theme = Ardentia
```

Se o Ghostty acompanha a aparência do sistema, combine o Ardentia com um tema claro à sua escolha:

```
theme = dark:Ardentia,light:<outro tema>
```

`ghostty +list-themes` mostra os temas disponíveis. No macOS o binário fica em `/Applications/Ghostty.app/Contents/MacOS/ghostty`, fora do PATH. O Ghostty carrega o tema primeiro, então qualquer cor definida na sua própria configuração vence a do tema.

## As 16 cores

| Índice | Nome ANSI | Cor no Ardentia | Hex |
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

## Demais cores

| Chave | Cor no Ardentia | Hex | Uso |
| --- | --- | --- | --- |
| `background` | Nota | `#161a30` | fundo da janela |
| `foreground` | Texto | `#dde2fa` | texto padrão |
| `cursor-color` | Ardentia | `#4de8d8` | cursor |
| `cursor-text` | Abismo | `#0b0d1a` | texto sob o cursor |
| `selection-background` | Ardentia a 24% sobre Nota | `#234b58` | seleção |
| `selection-foreground` | Texto | `#dde2fa` | texto selecionado |
| `split-divider-color` | Borda | `#272d52` | linha entre divisões |
| `unfocused-split-fill` | Abismo | `#0b0d1a` | escurecimento da divisão sem foco |

`split-divider-color` existe desde o Ghostty 1.1.0. O Ghostty escurece a divisão sem foco desenhando sobre ela um retângulo semitransparente, e `unfocused-split-fill` é a cor desse retângulo. A força do escurecimento fica com `unfocused-split-opacity`, que o tema não define.

## Fontes

O tema não define fonte. A família de código do Ardentia é Cascadia Code. Para usá-la, instale a fonte no sistema e ponha esta linha na sua própria configuração:

```
font-family = Cascadia Code
```

`ghostty +list-fonts` lista os nomes que o Ghostty aceita.

## Notas do porte

- O arquivo define só chaves de cor. A documentação do Ghostty avisa que um tema pode definir qualquer opção de configuração e deve ser revisado antes do uso. Este não tem fonte, opacidade nem estilo de cursor: as chaves são as das duas tabelas acima. É um arquivo curto, então leia antes de instalar.
- O fundo do terminal é Nota, a superfície contra a qual os contrastes do README principal foram medidos.
- O preto (black) é Relevo, quase a cor do fundo. Serve de fundo e de texto sobre fundo colorido. Um programa que escreve em preto sobre o fundo padrão fica ilegível, e `minimum-contrast = 1.1` na sua configuração do Ghostty resolve.
- O preto brilhante (bright black) é Tênue, a 5,6:1 sobre Nota. É a cor de sugestão de shell e de comentário em muito programa de terminal, então precisa ser legível. O Claude Code no tema `dark-ansi` a usa como fundo da caixa do prompt enviado, onde Texto mede 2,4:1.
- Se você usa o Claude Code, instale também o porte [`claude-code/`](../claude-code/README.pt-BR.md): ele corrige essa caixa, levando-a a Relevo.
- O vermelho e o verde brilhantes repetem a cor normal. A paleta não tem variante clara dessas duas, e inventar uma quebraria a regra de que toda cor vem da paleta.
- O magenta brilhante (bright magenta) é Água-viva, a luz que não cabia nos seis matizes normais.
- A seleção é uma mistura já calculada. As cores do Ghostty são `#RRGGBB`, `RRGGBB` ou um nome de cor X11, sem alfa, então `selection-background` é o Ardentia a 24% sobre Nota, o que dá `#234b58`. É a mesma seleção que o porte do Obsidian desenha, e a única cor do arquivo que não é uma das cores da paleta. Texto sobre ela mede 7,4:1.
- O tema não define as cores de realce da busca do Ghostty. Elas ficam no padrão do Ghostty.
- As 16 cores são as mesmas nos portes para Zed, VS Code e herdr.
