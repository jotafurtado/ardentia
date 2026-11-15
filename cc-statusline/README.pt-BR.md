# Ardentia para a status line do Claude Code

<a href="README.md">English</a> · <b>Português</b>

Referência da status line do Claude Code. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). A status line é um script Bash que o Claude Code roda para desenhar a linha abaixo do prompt. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `statusline.sh` | A status line. Lê o JSON que o Claude Code manda na entrada padrão e imprime uma linha em segmentos |
| `install.sh` | Copia a status line para a pasta de configuração do Claude Code |

## Requisitos

- `jq`, para ler o JSON.
- `git`, para o ramo e a contagem de arquivos alterados.
- Uma fonte de terminal com glifos Nerd Font, para as setas e os ícones.
- Um terminal com cor de 24 bits.

## Instalação com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/cc-statusline/install.sh
```

O script copia `statusline.sh` para `~/.claude/ardentia-statusline.sh`, ou para `$CLAUDE_CONFIG_DIR/ardentia-statusline.sh` quando essa variável está definida. Ele cria a pasta se faltar, deixa o arquivo executável e mostra onde o pôs. O arquivo entra com nome próprio, então um `statusline.sh` que já esteja na pasta fica como está.

O script não edita o `settings.json`.

## Instalação à mão

Copie `statusline.sh` desta pasta para `~/.claude/ardentia-statusline.sh` e deixe o arquivo executável:

```bash
cp ardentia/cc-statusline/statusline.sh ~/.claude/ardentia-statusline.sh
chmod +x ~/.claude/ardentia-statusline.sh
```

## Ativação

Ponha isto no `settings.json` do Claude Code, que por padrão é `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/ardentia-statusline.sh"
  }
}
```

Se o arquivo já tem uma entrada `statusLine`, troque-a.

## Segmentos

A status line é uma cápsula em Relevo `29;34;64`, com as pontas arredondadas. Os segmentos ficam lado a lado sobre esse fundo, separados por uma seta fina em Borda forte `58;66;115`. A cor vai no texto, e só onde ela diz alguma coisa. As cores estão no script como trincas RGB.

| Segmento | O que mostra | Cor do texto |
| --- | --- | --- |
| Pasta | `~` na pasta pessoal, o nome da pasta, ou `…/nome` quando a pasta está mais fundo dentro da pasta pessoal | Maré `124;178;255` |
| Git | O ramo, ou o commit abreviado quando não há ramo. Só dentro de um repositório | Anêmona `185;160;255` |
| Alterações | O número de arquivos alterados, quando há algum, e depois as linhas adicionadas e removidas na sessão | Arquivos em Lanterna `255;204;112`, linhas adicionadas em Sargaço `180;238;124`, linhas removidas em Coral `255;115;131`. O zero fica em Tênue `135;145;194` |
| Modelo | Um ícone da família do modelo, o nome do modelo e um ícone do nível de esforço | Ardentia `77;232;216` |
| Contexto | Tokens em uso sobre o tamanho da janela de contexto, com a porcentagem. O ícone muda em 25%, 50% e 75% | Sargaço abaixo de 50%, Lanterna de 50% a 74%, Coral a partir de 75% |
| Nome da sessão | O nome da sessão, cortado em 40 caracteres. Só quando a sessão tem nome | Tênue |

## Notas do porte

- O script começou como a status line que o autor já usava, cinco blocos sólidos em cinco cores. O que cada segmento mostra é o mesmo: textos, ícones, cortes e cálculos. O desenho mudou, para seguir o primeiro princípio do tema: o fundo fica quieto e a cor é um aviso.
- O contexto é o segmento que avisa. Fica em Sargaço enquanto há folga, passa a Lanterna na metade da janela e a Coral em três quartos.
- No segmento das alterações o zero fica em Tênue, então a cor só aparece quando linhas foram adicionadas ou removidas.
- Toda cor é uma das cores da paleta. As nove trincas ficam no topo do script, cada uma sob o nome da sua cor.
- Relevo mede 1,1:1 sobre Nota, o fundo do porte do Ghostty, então a cápsula é discreta nesse terminal. Toda cor de texto mede pelo menos 5:1 sobre Relevo.
- As cores são sequências de escape de 24 bits. Um terminal sem cor de 24 bits as mostra erradas.
- A status line define `GIT_OPTIONAL_LOCKS=0`. O Claude Code a chama com frequência, e sem isso o `git status` dela disputaria a trava do índice com os seus comandos do Git.
