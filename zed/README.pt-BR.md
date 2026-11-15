# Ardentia para o Zed

<a href="README.md">English</a> · <b>Português</b>

Referência do porte para o Zed. A visão geral, a paleta e os princípios estão no [README principal](../README.pt-BR.md). O arquivo do tema segue o schema de temas v0.2.0 do Zed. Este porte ainda não está publicado no registro de extensões do Zed e não tem capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `themes/ardentia.json` | A família de temas, com um único tema escuro chamado Ardentia |
| `extension.toml` | O manifesto da extensão, com o id `ardentia-theme` |
| `LICENSE` | Cópia da licença MIT da raiz do repositório. O registro de extensões do Zed pede a licença dentro da pasta da extensão |
| `install.sh` | Copia o tema para a pasta de temas locais do Zed |

## Instalar à mão

O Zed carrega qualquer arquivo de tema posto na pasta de temas locais. Não é preciso extensão.

1. Baixe [`themes/ardentia.json`](themes/ardentia.json).
2. Ponha o arquivo em `~/.config/zed/themes/` no macOS e no Linux, ou em `%USERPROFILE%\AppData\Roaming\Zed\themes\` no Windows. Crie a pasta se ela não existir.
3. O tema aparece no seletor de temas na próxima vez que o Zed carregar.

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/zed/install.sh
```

O script copia `ardentia.json` para `~/.config/zed/themes` e cria a pasta se ela faltar. No Linux ele usa `$XDG_CONFIG_HOME/zed/themes` quando essa variável está definida. No macOS o Zed ignora essa variável, e o script também. Para mandar o arquivo para outro lugar, defina `ZED_THEMES_DIR`:

```bash
ZED_THEMES_DIR="/caminho/dos/temas" ./ardentia/zed/install.sh
```

Ele não edita o `settings.json` e não troca o tema ativo.

## Instalar como extensão de desenvolvimento

Esta pasta também é uma extensão de tema do Zed. Para carregar sem publicar:

1. Clone o repositório.
2. No Zed, abra a página de extensões e clique em `Install Dev Extension`, ou rode a ação `zed::InstallDevExtension`.
3. Selecione a pasta `zed/` do clone.

## Selecionar o tema

Abra o seletor de temas pela paleta de comandos (ação `theme_selector::Toggle`), vá até Ardentia e aperte enter. O Zed grava a escolha no seu arquivo de configurações.

Para definir à mão no `settings.json`, use o Ardentia como tema escuro, já que ele não tem variante clara:

```json
{
  "theme": {
    "mode": "system",
    "light": "One Light",
    "dark": "Ardentia"
  }
}
```

## Mapeamento de cores

Toda cor do arquivo vem da paleta do Ardentia no README principal, das três luzes claras dela (Ardentia clara, Maré clara, Lanterna clara) ou de duas cores de apoio, Base-40 `#4a5388` e a sombra `#04050c`. Algumas levam um valor de alfa.

### Superfícies

| Onde | Cor |
| --- | --- |
| Editor, margem do editor, barra de ferramentas, terminal, aba ativa | Nota `#161a30` |
| Painéis, faixa de abas, abas inativas, menus e flutuantes | Fundo `#101326` |
| Barra de título, barra de status, fundo do aplicativo | Abismo `#0b0d1a` |
| Hover, item selecionado de lista, botões, linha atual | Relevo `#1d2240` |
| Bordas, divisores, guias de indentação, guia de quebra | Borda `#272d52` |
| Indicador da barra de rolagem, guia de indentação ativa | Borda forte `#3a4273`, a 80% no indicador em repouso |
| Texto do editor e da interface | Texto `#dde2fa` |
| Texto secundário, ícones | Suave `#a8b0db` |
| Placeholders, ícones secundários, dicas | Tênue `#8791c2` |
| Previsões de edição | Tênue a 80% |
| Números de linha, caracteres invisíveis, arquivos ignorados | Base-40 `#4a5388`, com o número da linha atual em Suave |
| Cursor, borda de foco, texto e ícones de acento | Ardentia `#4de8d8` |
| Seleção | Ardentia a 24% |
| Par de colchetes | Ardentia a 18% |
| Outras ocorrências do símbolo sob o cursor | Ardentia a 12% |
| Resultados de busca | Lanterna `#ffcc70` a 22%, e a 45% no resultado atual |

| Estado | Cor |
| --- | --- |
| Erro, removido | Coral `#ff7383` |
| Aviso, conflito | Estrela `#ffa26b` |
| Informação, renomeado | Maré `#7cb2ff` |
| Sucesso, criado | Sargaço `#b4ee7c` |
| Modificado | Lanterna `#ffcc70` |

### Sintaxe

| Elemento | Cor | Estilo |
| --- | --- | --- |
| Comentários, comentários de documentação | Tênue `#8791c2` | itálico |
| Palavras-chave, `this` e `self` | Água-viva `#ff7ac6` | itálico |
| Diretivas de pré-processador | Água-viva `#ff7ac6` | |
| Operadores, rótulos, lifetimes, decoradores | Anêmona `#b9a0ff` | |
| Funções e métodos | Maré `#7cb2ff` | |
| Tipos, construtores, enums, namespaces, módulos, conceitos | Lanterna `#ffcc70` | |
| Variáveis, parâmetros | Texto `#dde2fa` | |
| Propriedades, atributos | Ardentia `#4de8d8` | |
| Números, booleanos, constantes, membros de enum, unidades de CSS | Estrela `#ffa26b` | |
| Strings | Sargaço `#b4ee7c` | |
| Escapes dentro de string | Ardentia `#4de8d8` | |
| Expressões regulares | Lanterna `#ffcc70` | |
| Tags | Coral `#ff7383` | |
| Pontuação, colchetes, delimitadores | Suave `#a8b0db` | |

| Marcação | Cor | Estilo |
| --- | --- | --- |
| Títulos | Água-viva `#ff7ac6` | negrito |
| Negrito | Lanterna `#ffcc70` | negrito |
| Itálico | Anêmona `#b9a0ff` | itálico |
| Código em linha e texto literal | Coral `#ff7383` | |
| Texto de link, marcadores de lista | Ardentia `#4de8d8` | |
| Endereço de link | Maré `#7cb2ff` | |
| Marcas de formatação, tachado | Tênue `#8791c2` | |

### Terminal

O terminal fica sobre Nota `#161a30`, com texto em Texto `#dde2fa`. As 16 cores ANSI são as mesmas nos portes para Zed, VS Code, Ghostty e app Herdr.

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

## Fontes

Um tema do Zed leva cores, e estilo e peso de fonte para a sintaxe. Ele não escolhe família de fonte, então este porte não define nenhuma. No Ardentia, o código usa Cascadia Code e a interface usa Geist. Para usar as duas no Zed, instale ambas no sistema e ponha isto no `settings.json`:

```json
{
  "buffer_font_family": "Cascadia Code",
  "ui_font_family": "Geist"
}
```

## Notas do porte

- O Zed pede uma variante esmaecida (`dim`) de cada cor ANSI e a paleta não tem nenhuma. Cada cor esmaecida é a cor normal a 60% de opacidade, e o texto esmaecido é Tênue.
- O vermelho e o verde brilhantes repetem a cor normal. A paleta não tem variante clara dessas duas.
- A primeira entrada de `players`, que é você, usa Ardentia, a cor do cursor. As demais seguem o espectro dos títulos: Água-viva, Anêmona, Maré, Sargaço, Lanterna, Estrela, Coral.
- `accents` lista as seis cores dos títulos em ordem: Água-viva, Anêmona, Maré, Ardentia, Sargaço, Lanterna.
- Os temas do Zed estilizam os títulos de Markdown por uma única entrada, `title`, então todo nível sai em Água-viva e negrito. O espectro nível a nível do porte do Obsidian não existe aqui.
- A gramática de Markdown do Zed marca só o marcador da citação, não o texto citado. O marcador sai em Tênue e o texto fica na cor padrão.
- O Zed usa a mesma captura `attribute` para nomes de atributo HTML e para atributos de linguagens como Rust e C. Este porte pinta a captura de Ardentia, como uma propriedade, então `#[derive]` em Rust sai em Ardentia.
- O schema publicado está atrás do app. Além das 142 chaves do schema v0.2.0, o tema define 15 chaves que o Zed 1.28.1 lê e o schema ainda não lista: `search.active_match_background`, `editor.hover_line_number`, `editor.debugger_active_line.background`, `debugger.accent`, `drop_target.border` e dez chaves `version_control`. Sem elas o diff por palavra, os marcadores de conflito e o estado de conflito no painel Git sairiam nas cores padrão do Zed.
- O schema não tem chave para o contorno das superfícies flutuantes. Menus e flutuantes usam `border.variant`, que este porte mantém em Borda, a mesma cor dos divisores.
- O schema não tem chave para um indicador de aba. A aba ativa se distingue pelo fundo, Nota sobre o Fundo da faixa de abas.
- Sobre o texto selecionado, os comentários e parte da sintaxe medem menos de 4,5:1, porque a seleção é o Ardentia a 24%, como no tema de origem.
- A pasta tem o formato de uma extensão de tema: o manifesto, a pasta `themes` e a licença dentro da pasta. Publicar no registro é um passo separado, que ainda não foi dado.
