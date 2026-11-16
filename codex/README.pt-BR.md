# Ardentia para o Codex

<a href="README.md">English</a> · <b>Português</b>

Referência do porte do Codex. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). O porte é um tema de sintaxe para a interface de terminal do Codex, um arquivo `.tmTheme`. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `ardentia.tmTheme` | O tema. Toda cor é uma da paleta, escrita em `#rrggbb` |
| `install.sh` | Copia o tema para a pasta onde o Codex lê temas |

## O que o tema cobre

O Codex deixa um `.tmTheme` colorir os blocos de código e os diffs que ele desenha no terminal. As cores do resto da interface vêm do terminal, então combine este tema com o tema Ardentia do [Ghostty](../ghostty/) ou do [Rex](../rex/). O aplicativo desktop do Codex não lê este arquivo.

## Requisitos

- Codex CLI com suporte a `.tmTheme` próprio. O porte foi escrito na versão 0.169.0.
- Um terminal com cor de 24 bits.

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/codex/install.sh
```

O script copia `ardentia.tmTheme` para `~/.codex/themes/`, ou para `$CODEX_HOME/themes/` quando essa variável está definida, e mostra onde o arquivo foi parar. Quando já existe ali um `ardentia.tmTheme` diferente, o script o guarda como `ardentia.tmTheme.bak-<data>` antes de escrever. Ele não edita o `config.toml`.

## Instalar à mão

Copie `ardentia.tmTheme` desta pasta para `~/.codex/themes/`, mantendo o nome: o nome do arquivo, sem `.tmTheme`, é o nome do tema.

## Ativar

No Codex, digite `/theme` e escolha `ardentia`, com prévia ao vivo enquanto você navega. Ou defina no `~/.codex/config.toml`:

```toml
[tui]
theme = "ardentia"
```

Para voltar, escolha outro tema ou remova a linha `theme`: o arquivo continua onde está.

## Cores

| Grupo | Cores |
| --- | --- |
| Editor | Fundo `#101326`, texto Texto `#dde2fa`, cursor Ardentia `#4de8d8`, seleção Borda `#272d52`, linha atual Nota `#161a30`, calha em Tênue `#8791c2` |
| Sintaxe | Comentário em Tênue, palavra-chave em Água-viva `#ff7ac6`, função em Maré `#7cb2ff`, variável em Texto, string em Sargaço `#b4ee7c`, número e escape em Estrela `#ffa26b`, tipo em Lanterna `#ffcc70`, operador em Anêmona `#b9a0ff`, pontuação em Suave `#a8b0db`, inválido em Coral `#ff7383` |
| Markdown | Título em Água-viva, link em Maré, código em Coral, citação em Suave, ênfase em Anêmona, negrito em Lanterna, listas em Ardentia |
| Diff | Adição em Sargaço, remoção em Coral, cabeçalho de trecho em Anêmona |

## Notas do porte

- O diff não tem fundo tingido, então uma linha adicionada e uma removida se distinguem pela cor do texto. A paleta não tem verde nem vermelho escuro para tingir.
- Toda cor é `#rrggbb`. `bun scripts/check-themes.ts`, na raiz do repositório, confere isso e que cada uma pertence à paleta. Ele não roda o Codex, então um tema que a conferência aceita ainda pode ser recusado pelo Codex, que então volta ao tema padrão.
- O tema não foi testado na tela.
