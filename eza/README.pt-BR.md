# Ardentia para o eza

<a href="README.md">English</a> · <b>Português</b>

Referência do porte do eza. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). O porte é um `theme.yml`: ele silencia o metadado de uma listagem longa e deixa a cor só onde ela diz alguma coisa. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `theme.yml` | O tema. Toda cor é uma da paleta, escrita em `#rrggbb` |
| `install.sh` | Copia o tema para a pasta onde o eza o lê |

## Requisitos

- eza com suporte a tema. O porte foi escrito e testado na versão 0.23.5.
- Um terminal com cor de 24 bits.

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/eza/install.sh
```

O script copia `theme.yml` para a pasta onde o eza o lê e mostra onde o arquivo foi parar:

| Sistema | Pasta |
| --- | --- |
| macOS | `~/Library/Application Support/eza` |
| Linux | `$XDG_CONFIG_HOME/eza`, ou `~/.config/eza` quando essa variável não está definida |

Para mandar o arquivo para outro lugar, defina `EZA_CONFIG_DIR`, a pasta que o próprio eza lê primeiro. Quando já existe ali um `theme.yml` diferente, o script o guarda como `theme.yml.bak-<data>` antes de escrever. Ele não edita o `~/.zshrc`.

## Instalar à mão

Copie `theme.yml` desta pasta para a pasta da tabela acima, mantendo o nome `theme.yml`.

## Ativar

Não há o que ligar: o eza lê o tema a cada execução, sem flag. Para voltar atrás, apague o arquivo ou ponha a cópia de segurança no lugar.

O tema não esconde coluna nem muda a ordem delas: a ordem é fixa no eza. Para tirar a coluna do dono, que numa máquina pessoal é sempre a mesma, faça isso no comando. Este alias mantém também a linha de cabeçalho:

```zsh
alias ll="eza -lah --no-user --icons --git"
```

## Cores

O metadado fica em Tênue `#8791c2`, e a cor sobra para o que pede atenção. Um campo que não está na tabela fica com o padrão do eza.

| Campo | Cor |
| --- | --- |
| Arquivo comum, todo tipo de arquivo (imagem, vídeo, áudio, compactado, documento, código) | Texto `#dde2fa` |
| Pasta, ponto de montagem | Maré `#7cb2ff` |
| Link simbólico | Ardentia `#4de8d8` |
| Executável | Sargaço `#b4ee7c`, negrito |
| Pipe, socket, dispositivo, arquivo especial | Anêmona `#b9a0ff` |
| Link quebrado e o destino dele | Coral `#ff7383` |
| Permissões, tamanho, dono, grupo, data, inode, blocos, octal, flags, pontuação | Tênue |
| Linha de cabeçalho, com `-h` | Texto, sublinhado |
| Bits especiais de permissão, arquivo com mais de um link | Lanterna `#ffcc70` |
| Dono e grupo `root` | Coral |
| Git: novo | Sargaço |
| Git: modificado | Lanterna |
| Git: apagado, em conflito | Coral |
| Git: renomeado | Ardentia |
| Git: ignorado | Tênue |
| Repositório Git: ramo principal | Ardentia |
| Repositório Git: outro ramo | Lanterna |
| Repositório Git: limpo | Sargaço |
| Repositório Git: sujo | Lanterna |

## Notas do porte

- O `EZA_COLORS` vence o tema, chave por chave. Se você já o tem definido, as chaves dele cobrem as daqui.
- `--color=never` desliga o tema inteiro.
- Os tipos de arquivo (imagem, vídeo, documento e afins) saem todos em Texto, para a cor não repetir o que o ícone já diz. Os ícones não fazem parte do porte: eles tomam a cor do nome.
- O eza descarta o tema inteiro, sem aviso, quando uma cor dele não é válida. Por isso toda cor é `#rrggbb`, e por isso `bun scripts/check-themes.ts`, na raiz do repositório, as confere contra a paleta.
- No macOS o eza não lê `~/.config/eza` nem `$XDG_CONFIG_HOME`, então o script grava em `~/Library/Application Support/eza`. Só o macOS foi testado.
- As 16 cores do terminal não vêm deste arquivo. Um terminal com o Ardentia, como o Ghostty ou o Rex, já desenha o que o eza deixa no padrão.
