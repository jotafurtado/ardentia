# Ardentia para o Codex

<a href="README.md">English</a> · <b>Português</b>

Referência do porte do Codex. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). O porte é um tema de sintaxe para a interface de terminal do Codex, um arquivo `.tmTheme`. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `ardentia.tmTheme` | O tema. Toda cor é uma da paleta, escrita em `#rrggbb` |
| `desktop.toml` | O bloco do app desktop do Codex, para colar no `config.toml` |
| `install.sh` | Copia o tema para a pasta onde o Codex lê temas |

## O que o tema cobre

O Codex deixa um `.tmTheme` colorir os blocos de código e os diffs que ele desenha no terminal. As cores do resto da interface vêm do terminal, então combine este tema com o tema Ardentia do [Ghostty](../ghostty/) ou do [Rex](../rex/). O aplicativo desktop do Codex não lê este arquivo; ele tem um bloco próprio, na seção abaixo.

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

## Aplicativo desktop

O aplicativo desktop toma as cores da janela de `[desktop.appearanceDarkChromeTheme]` no `~/.codex/config.toml`. Cole o `desktop.toml` ali, no lugar de uma tabela de mesmo nome que já exista, porque o TOML não aceita a mesma tabela duas vezes. O bloco define o destaque em Ardentia `#4de8d8`, o texto em Texto, o fundo em Fundo, o diff em Sargaço e Coral e as skills em Anêmona. As fontes são Cascadia Code no código e Geist na interface. O script não mexe nesse arquivo.

O código dentro do aplicativo vem de `appearanceDarkCodeThemeId`, que recebe o id de um tema embutido no aplicativo. O porte não tem tema de código para o aplicativo.

## Notas do porte

- O diff não tem fundo tingido, então uma linha adicionada e uma removida se distinguem pela cor do texto. A paleta não tem verde nem vermelho escuro para tingir.
- Toda cor é `#rrggbb`. `bun scripts/check-themes.ts`, na raiz do repositório, confere isso e que cada uma pertence à paleta. Ele não roda o Codex, então um tema que a conferência aceita ainda pode ser recusado pelo Codex, que então volta ao tema padrão.
- As chaves do bloco desktop foram copiadas de um `config.toml` existente, não de um esquema, porque não achei nenhum. Nem o tema do CLI nem o bloco desktop foram testados na tela.
