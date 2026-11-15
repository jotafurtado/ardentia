# Ardentia para o VS Code

<a href="README.md">English</a> · <b>Português</b>

Referência do porte para o VS Code. A visão geral, a paleta e os princípios estão no [README principal](../README.pt-BR.md). O porte é uma extensão de tema de cores. Ainda não está no Visual Studio Marketplace nem no Open VSX, por isso a instalação parte desta pasta. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `package.json` | O manifesto da extensão. Registra um tema escuro, Ardentia, em `contributes.themes` |
| `themes/ardentia-color-theme.json` | O tema: cores do workbench em `colors`, regras TextMate em `tokenColors` e regras semânticas em `semanticTokenColors` |
| `CHANGELOG.md` | Histórico de versões deste porte |
| `LICENSE` | Cópia da licença MIT da raiz do repositório, para a licença ir dentro do pacote da extensão |
| `.vscodeignore` | Deixa o `install.sh` e os arquivos ocultos fora do pacote `.vsix` |
| `install.sh` | Copia a extensão para a pasta de extensões do VS Code |

## Instalar à mão

O VS Code carrega extensões da pasta de extensões dele: `~/.vscode/extensions` no macOS e no Linux, `%USERPROFILE%\.vscode\extensions` no Windows.

1. Clone o repositório, ou baixe uma cópia.
2. Copie a pasta `vscode/` para dentro da pasta de extensões e dê à cópia o nome `jotafurtado.ardentia-1.0.0`.
3. Reinicie o VS Code.

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/vscode/install.sh
```

O script lê a versão no `package.json` e copia `package.json`, `themes/`, os dois README, `CHANGELOG.md` e `LICENSE` para `~/.vscode/extensions/jotafurtado.ardentia-1.0.0`. Se essa pasta já existir, ela é substituída. Nada mais na pasta de extensões é tocado. Para mandar a extensão para outro lugar, defina `VSCODE_EXTENSIONS_DIR`:

```bash
VSCODE_EXTENSIONS_DIR="/caminho/das/extensoes" ./ardentia/vscode/install.sh
```

Ele não edita o `settings.json` e não troca o tema ativo.

## Instalar por um `.vsix`

A pasta pode ser empacotada com o `vsce`, a ferramenta de empacotamento de extensões do VS Code, que precisa do Node.js:

```bash
npm install -g @vscode/vsce
cd ardentia/vscode
vsce package
code --install-extension ardentia-1.0.0.vsix
```

O `vsce package` grava o arquivo `.vsix` nesta pasta. No lugar do último comando, você pode abrir a vista de extensões do VS Code, escolher `Views and More Actions...` e depois `Install from VSIX...`.

## Selecionar o tema

Rode `Preferences: Color Theme` na paleta de comandos, ou vá em File, Preferences, Theme, Color Theme, e escolha Ardentia.

## Mapeamento de cores

Toda cor do arquivo vem da paleta do Ardentia no README principal, das três luzes claras dela (Ardentia clara, Maré clara, Lanterna clara) ou de duas cores de apoio, Base-40 `#4a5388` e a sombra `#04050c`. Algumas levam um valor de alfa.

### Superfícies

| Onde | Cor |
| --- | --- |
| Editor, terminal, aba ativa, breadcrumbs, minimapa | Nota `#161a30` |
| Barra lateral, painel, faixa de abas, abas inativas | Fundo `#101326` |
| Barra de título, barra de atividades, barra de status | Abismo `#0b0d1a` |
| Menus, paleta de comandos, hover, sugestões, notificações, widget de busca | Fundo `#101326`, com contorno em Borda forte `#3a4273` |
| Campos de entrada, dropdowns | Abismo `#0b0d1a`, com contorno em Borda `#272d52`. Com foco o contorno é Ardentia |
| Hover em listas e abas, item selecionado em lista sem foco, linha atual | Relevo `#1d2240` |
| Item selecionado em lista com foco | Ardentia a 12% |
| Divisores, guias de indentação, réguas | Borda `#272d52` |
| Indicador da barra de rolagem, guia de indentação ativa | Borda forte `#3a4273`, a 80% no indicador em repouso |
| Texto no editor, nos hovers, na paleta de comandos e nas notificações | Texto `#dde2fa` |
| Rótulos da barra lateral, itens de menu, abas inativas, texto da barra de status | Suave `#a8b0db` |
| Placeholders, descrições, ícones em repouso, CodeLens, dicas, anotações de blame do Git | Tênue `#8791c2` |
| Sugestões em linha | Tênue a 80% |
| Texto desabilitado | Tênue a 60% |
| Números de linha, espaços em branco, arquivos ignorados | Base-40 `#4a5388`, com o número da linha atual em Suave |
| Cursor, borda de foco, indicador da aba ativa, links, barra de progresso, botões, selos | Ardentia `#4de8d8`, com Abismo no texto sobre ela |
| Seleção | Ardentia a 24% |
| Outras ocorrências da palavra ou da seleção | Ardentia a 12% |
| Resultados de busca | Lanterna `#ffcc70` a 22%, e a 45% no resultado atual, com o texto dele em Texto |
| Linhas alteradas num diff, e o trecho alterado dentro delas | Sargaço ou Coral a 8% na linha, mais 12% no trecho |
| Editor de mesclagem em três vias | Sargaço nas alterações e Coral na base a 12%, e a 18% nas palavras alteradas |

| Estado | Cor |
| --- | --- |
| Erro, removido | Coral `#ff7383` |
| Aviso, conflito | Estrela `#ffa26b` |
| Informação, renomeado | Maré `#7cb2ff` |
| Sucesso, adicionado, não rastreado | Sargaço `#b4ee7c` |
| Modificado | Lanterna `#ffcc70` |

### Sintaxe

| Elemento | Cor | Estilo |
| --- | --- | --- |
| Comentários, comentários de documentação | Tênue `#8791c2` | itálico |
| Palavras-chave, `this` e `self` | Água-viva `#ff7ac6` | itálico |
| Diretivas de pré-processador | Água-viva `#ff7ac6` | |
| Operadores, `and`, `or`, `not`, `in` e `is` do Python, rótulos, lifetimes, âncoras YAML, decoradores, pseudo-classes CSS | Anêmona `#b9a0ff` | |
| Funções, métodos, macros | Maré `#7cb2ff` | |
| Tipos, classes, interfaces, enums, namespaces, referências a tipo em Java, tipos embutidos de C#, seletores CSS de classe e de id | Lanterna `#ffcc70` | |
| Variáveis, parâmetros | Texto `#dde2fa` | |
| Propriedades, chaves de objeto, atributos HTML, propriedades CSS, chaves de JSON, YAML e TOML | Ardentia `#4de8d8` | |
| Números, booleanos, constantes, `null`, membros de enum, unidades de CSS | Estrela `#ffa26b` | |
| Strings | Sargaço `#b4ee7c` | |
| Escapes dentro de string | Ardentia `#4de8d8` | |
| Expressões regulares | Lanterna `#ffcc70` | |
| Tags HTML, JSX e XML | Coral `#ff7383` | |
| Pontuação, colchetes, delimitadores | Suave `#a8b0db` | |

| Marcação | Cor | Estilo |
| --- | --- | --- |
| Títulos Markdown de 1 a 6 | Água-viva, Anêmona, Maré, Ardentia, Sargaço, Lanterna | negrito |
| Títulos em formatos com um só escopo de título | Água-viva `#ff7ac6` | negrito |
| Negrito | Lanterna `#ffcc70` | negrito |
| Itálico | Anêmona `#b9a0ff` | itálico |
| Código em linha e blocos crus | Coral `#ff7383` | |
| Citações | Suave `#a8b0db` | itálico |
| Texto de link, marcadores de lista | Ardentia `#4de8d8` | |
| Endereço de link | Maré `#7cb2ff` | |
| Marcas de formatação, tachado | Tênue `#8791c2` | |

### Terminal

O terminal integrado fica sobre Nota `#161a30`, com texto em Texto `#dde2fa`, cursor em Ardentia e seleção em Ardentia a 24%. As 16 cores ANSI são as mesmas nos portes para Zed, VS Code, Ghostty e app Herdr.

| ANSI | Normal | Brilhante |
| --- | --- | --- |
| Preto | Relevo `#1d2240` | Tênue `#8791c2` |
| Vermelho | Coral `#ff7383` | Coral `#ff7383` |
| Verde | Sargaço `#b4ee7c` | Sargaço `#b4ee7c` |
| Amarelo | Lanterna `#ffcc70` | Lanterna clara `#ffe2a8` |
| Azul | Maré `#7cb2ff` | Maré clara `#a9ccff` |
| Magenta | Anêmona `#b9a0ff` | Água-viva `#ff7ac6` |
| Ciano | Ardentia `#4de8d8` | Ardentia clara `#8ff5ea` |
| Branco | Suave `#a8b0db` | Texto `#dde2fa` |

## Realce semântico

O tema define `semanticHighlighting` como `true`. Com a configuração `editor.semanticHighlighting.enabled` em `configuredByTheme`, que a documentação do VS Code dá como padrão, um servidor de linguagem que fornece tokens semânticos refina as cores das regras TextMate.

`semanticTokenColors` tem regras para os tipos de token padrão (`namespace`, `class`, `enum`, `interface`, `struct`, `typeParameter`, `type`, `parameter`, `variable`, `property`, `enumMember`, `decorator`, `event`, `function`, `method`, `macro`, `label`, `comment`, `string`, `keyword`, `number`, `regexp`, `operator`), com as mesmas cores da tabela de sintaxe. Um tipo de token sem regra cai nas regras TextMate.

Dois modificadores mudam a cor:

- `variable.readonly` é Estrela, a cor das constantes. JavaScript e TypeScript são a exceção: neles `const` declara quase toda variável local, então uma ligação `const` fica em Texto, como qualquer variável.
- `property.static.readonly` é Estrela, para constantes de classe. As outras propriedades são Ardentia.

## Fontes

Um tema de cores do VS Code leva cores e estilos de fonte para os tokens, não uma família de fonte, por isso este porte não define nenhuma. No Ardentia, o código usa Cascadia Code. Para usá-la no VS Code, instale a fonte no sistema e defina `editor.fontFamily` no `settings.json`:

```json
{
  "editor.fontFamily": "Cascadia Code"
}
```

## Notas do porte

- O porte foi escrito a partir da documentação do VS Code. Todo identificador de `colors` consta da referência Theme Color, mas o tema ainda não foi carregado em um VS Code em execução. Se algo parecer errado, abra uma issue.
- Valores de alfa aparecem só em `colors`. `tokenColors` e `semanticTokenColors` usam cores opacas, porque as regras semânticas não aceitam transparência.
- As cores dos pares de colchetes (`editorBracketHighlight.foreground1` a `6`) seguem o espectro dos títulos: Água-viva, Anêmona, Maré, Ardentia, Sargaço, Lanterna. Elas aparecem quando a colorização de pares de colchetes está ligada.
- A aba ativa tem o fundo do editor e uma linha Ardentia no topo (`tab.activeBorderTop`).
- A barra de status continua em Abismo durante a depuração. Só o texto e a borda dela passam para Estrela.
- O indicador remoto, à esquerda da barra de status, é Relevo com texto Ardentia, não um bloco sólido na cor de acento.
- Tags e tipos dentro de comentários de documentação, como `@param` no JSDoc e no PHPDoc, ficam em Tênue itálico com o resto do comentário.
- Em JavaScript e TypeScript, uma constante escrita em maiúsculas pode mudar de Estrela para Texto quando o servidor de linguagem carrega. As regras TextMate pintam os usos dela de Estrela, e a regra semântica da ligação `const` a pinta de Texto.
- Sobre o texto selecionado, os comentários e parte da sintaxe medem menos de 4,5:1, porque a seleção é o Ardentia a 24%, como no tema de origem.
- No terminal, o vermelho e o verde brilhantes repetem a cor normal. A paleta não tem variante clara dessas duas.
- O arquivo também define as chaves que a referência Theme Color lista para a interface moderna (`modernUI.*`, `surface.*`, `modernTab.*`, `modernEditorTab.*`, `modernActivityBar.*`), com Abismo em volta das superfícies flutuantes.
- O manifesto não tem `icon`. O VS Code pede um PNG de pelo menos 128x128 pixels, e o porte ainda não tem um.
- A pasta tem o formato de uma extensão: o manifesto, a pasta `themes`, o changelog e a licença dentro dela. Publicar no Marketplace ou no Open VSX é um passo à parte, que ainda não foi dado.
