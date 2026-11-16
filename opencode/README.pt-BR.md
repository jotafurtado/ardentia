# Ardentia para o OpenCode

<a href="README.md">English</a> · <b>Português</b>

Referência do porte do OpenCode. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). O porte é um tema para a interface de terminal do OpenCode, no formato V2 de temas, só com o modo escuro. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `ardentia.json` | O tema. Toda cor é uma da paleta, escrita em `#rrggbb` |
| `install.sh` | Copia o tema para a pasta onde o OpenCode lê temas |

## Requisitos

- OpenCode com o formato V2 de temas. O porte foi escrito na versão 2.3.0.
- Um terminal com cor de 24 bits.

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/opencode/install.sh
```

O script copia `ardentia.json` para `~/.config/opencode/themes/`, ou para `$XDG_CONFIG_HOME/opencode/themes/` quando essa variável está definida, e mostra onde o arquivo foi parar. Para mandar o arquivo para outro lugar, defina `OPENCODE_THEMES_DIR` com a pasta. Quando já existe ali um `ardentia.json` diferente, o script o guarda como `ardentia.json.bak-<data>` antes de escrever. Ele não edita o `cli.json`, o `opencode.json` nem o `~/.zshrc`.

## Instalar à mão

Copie `ardentia.json` desta pasta para `~/.config/opencode/themes/`, mantendo o nome: o nome do arquivo, sem `.json`, é o nome do tema. Um tema em `.opencode/themes/` de um projeto toma o lugar de um global com o mesmo nome.

## Ativar

No OpenCode, tecle `Ctrl+P`, escolha Open settings, depois Theme, e escolha `ardentia`. Ou defina no `~/.config/opencode/cli.json`:

```json
{
  "theme": { "name": "ardentia", "mode": "dark" }
}
```

Para voltar atrás, escolha outro tema, ou ponha de novo o `theme.name` antigo: o arquivo continua onde está.

## Cores

Só o modo escuro está definido. Os fundos vão de Fundo `#101326` a Borda forte `#3a4273`, e a cor fica para o que diz alguma coisa.

| Grupo | Cores |
| --- | --- |
| Fundo | Nota `#161a30`. Superfícies elevadas em Relevo `#1d2240`, Borda `#272d52` e Borda forte `#3a4273`. Campos de formulário em Fundo |
| Texto | Texto `#dde2fa`. Esmaecido em Suave `#a8b0db`, apagado em Tênue `#8791c2` |
| Ações | Primária em Ardentia `#4de8d8`, com texto em Abismo `#0b0d1a`. Secundária em Relevo. Destrutiva em Coral `#ff7383` |
| Avisos | Erro em Coral, alerta em Lanterna `#ffcc70`, sucesso em Sargaço `#b4ee7c`, informação em Maré `#7cb2ff` |
| Borda e barra de rolagem | Borda e Borda forte |
| Diff | Adicionado em Sargaço, removido em Coral, contexto em Tênue, cabeçalho do trecho em Anêmona `#b9a0ff`. O fundo de toda linha é Relevo |
| Sintaxe | Comentário em Tênue, palavra-chave em Água-viva `#ff7ac6`, função em Maré, variável em Texto, texto literal em Sargaço, número em Estrela `#ffa26b`, tipo em Lanterna, operador em Anêmona, pontuação em Suave |
| Markdown | Título em Água-viva, link em Maré, texto do link em Ardentia, código em Coral, citação em Suave, ênfase em Anêmona, negrito em Lanterna, listas em Ardentia |
| Escalas de matiz e categorias | `accent` e `interactive` apontam para Ardentia. `neutral` vai de Texto a Fundo em nove passos. Os outros matizes repetem a cor da paleta. As categorias usam os matizes coloridos |

## Notas do porte

- O diff não tem fundo tingido, então uma linha adicionada e uma removida se distinguem pela cor do texto, e não por uma faixa verde ou vermelha. A paleta não tem verde nem vermelho escuro para tingir.
- O OpenCode pede nove passos para cada escala de cor. A paleta não tem escala assim, então cada matiz repete a cor da paleta, com o primeiro passo mais claro para Ardentia, Maré e Lanterna. O efeito é que os passos que o OpenCode usa para clarear ou escurecer uma cor não a mudam.
- O tema só tem o modo escuro. Com `"mode": "light"` ou `"system"` o OpenCode usa o modo que existe, então o resultado é um tema escuro. Isso foi lido no código do OpenCode e não foi testado na tela.
- Toda cor é `#rrggbb`. `bun scripts/check-themes.ts`, na raiz do repositório, confere isso, as chaves que o OpenCode exige e as referências entre cores. Ele não roda o OpenCode, então um tema que a conferência aceita ainda pode ser recusado pelo OpenCode.
- O porte usa o formato V2. O formato mais antigo, com `defs` e `theme`, não faz parte do porte.
