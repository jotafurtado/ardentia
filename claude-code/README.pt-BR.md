# Ardentia para o Claude Code

<a href="README.md">English</a> · <b>Português</b>

Referência do porte do Claude Code. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). O porte é um tema personalizado, `ardentia.json`: ele fica por cima do tema nativo `dark-ansi`, que desenha com as 16 cores do terminal, e corrige os fundos que o `dark-ansi` pinta com a cor errada. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `ardentia.json` | O tema. Toda cor é uma da paleta, escrita em `#rrggbb` |
| `install.sh` | Copia o tema para a pasta onde o Claude Code o lê |

## Requisitos

- Claude Code com temas personalizados. O porte foi escrito e testado na versão 2.1.332.
- Um terminal com o Ardentia, como o [Ghostty](../ghostty/README.pt-BR.md) ou o [Rex](../rex/README.pt-BR.md): tudo o que o tema não sobrescreve vem das 16 cores do terminal.
- Um terminal com cor de 24 bits.

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/claude-code/install.sh
```

O script copia `ardentia.json` para `~/.claude/themes` e mostra onde o arquivo foi parar. Quando `CLAUDE_CONFIG_DIR` está definida, ele grava em `$CLAUDE_CONFIG_DIR/themes`. Quando já existe ali um `ardentia.json` diferente, o script o guarda como `ardentia.json.bak-<data>` antes de escrever. Ele não edita o `settings.json`.

## Instalar à mão

Copie `ardentia.json` desta pasta para `~/.claude/themes`, mantendo o nome `ardentia.json`.

## Ativar

Rode `/theme` no Claude Code e escolha Ardentia. O Claude Code observa a pasta, então o tema aparece na lista sem reiniciar. A outra forma é defini-lo no `~/.claude/settings.json`:

```json
{
  "theme": "custom:ardentia"
}
```

Para voltar atrás, escolha outro tema em `/theme`. Isso tira o Ardentia de uso e deixa o arquivo onde está.

## Cores

O porte sobrescreve seis chaves, todas de fundo. Qualquer outra chave fica com o valor do `dark-ansi`, uma das 16 cores do terminal.

| Chave | O que pinta | Cor |
| --- | --- | --- |
| `userMessageBackground` | Fundo da caixa do prompt enviado | Relevo `#1d2240` |
| `userMessageBackgroundHover` | A mesma caixa sob o ponteiro | Borda `#272d52` |
| `composerSidebarBackground` | Fundo da barra lateral do compositor | Relevo `#1d2240` |
| `memoryBackgroundColor` | Fundo da entrada de memória | Relevo `#1d2240` |
| `bashMessageBackgroundColor` | Fundo da entrada de comando do shell | Relevo `#1d2240` |
| `rate_limit_empty` | Trilho vazio do limite de uso | Borda `#272d52` |

## Notas do porte

- O tema só corrige os fundos. Texto, bordas, diffs e o resto vêm do terminal, então num terminal sem o Ardentia o resultado são as cores daquele terminal com estes seis fundos por cima.
- Sem este porte, o `dark-ansi` pinta a caixa do prompt enviado com o preto brilhante do terminal. Nos portes de terminal do Ardentia essa cor é Tênue `#8791c2`, a cor do texto apagado, e Texto sobre ela mede 2,4:1. Com o porte a caixa desce para Relevo, a 12,1:1.
- A seta antes do prompt enviado não tem chave própria: ela usa `inactive`, a chave de todo texto inativo da interface. O porte não mexe nela.
- O formato do tema personalizado foi lido do Claude Code 2.1.332, não de documentação pública, e pode mudar numa versão posterior. O Claude Code descarta, sem aviso, o override cuja chave o tema base não tem ou cuja cor ele não consegue ler. Por isso `bun scripts/check-themes.ts`, na raiz do repositório, confere as chaves contra a lista daquela versão e as cores contra a paleta.
- O Claude Code também aceita `rgb(...)`, `ansi:<nome>` e `ansi256(n)` como cor. O porte usa só `#rrggbb` da paleta.
- Não há variante clara. A status line é um porte à parte, o [cc-statusline](../cc-statusline/README.pt-BR.md).
