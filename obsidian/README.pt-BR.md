# Ardentia para o Obsidian

<a href="README.md">English</a> · <b>Português</b>

Referência da versão para o Obsidian. A visão geral, as capturas e a instalação estão no [README principal](../README.pt-BR.md). Testado no Obsidian 1.15.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `theme.css` | O tema. Treze seções, da paleta ao brilho, com o bloco do Style Settings no topo |
| `snippets/` | Snippets CSS opcionais: sem brilho, brilho dobrado e as fontes embutidas |
| `screenshots/` | Imagens usadas pelo README e pelo diretório da comunidade |
| `demo/`, `demo-en/` | Cofres de demonstração com uma nota para cada quadro do design, em português e em inglês |
| `scripts/` | O script que gera o snippet de fontes |
| `install.sh` | Copia o tema e os snippets para um cofre |

O `manifest.json` do tema fica na raiz do repositório, não aqui. O diretório da comunidade do Obsidian lê o arquivo na raiz do branch padrão.

## Medidas

| Variável | Valor | Uso |
| --- | --- | --- |
| `--ardentia-gap` | 8px | entre ilhas |
| `--ardentia-raio` | 14px | ilhas e modais |
| `--radius-m` | 10px | blocos e callouts |
| `--radius-s` | 7px | itens e abas |
| `--file-line-width` | 700px | coluna de leitura |
| `--line-height-normal` | 1.6 | corpo da nota |
| `--ribbon-width` | 44px | faixa de ícones |
| `--icon-stroke` | 1.75px | traço dos ícones |

Os títulos são medidos em `em` (H1 1.6, H2 1.35, H3 1.18, H4 1.06, H5 1, H6 0.85 em caixa alta espaçada), todos no peso 600. O tamanho do corpo é a configuração do próprio Obsidian, `--font-text-size`.

## Fontes

| Trabalho | Família | Variável |
| --- | --- | --- |
| Títulos | Bricolage Grotesque | `--h1-font` a `--h6-font` |
| Texto | Atkinson Hyperlegible Next | `--font-text-theme` |
| Interface | Geist | `--font-interface-theme` |
| Código | Cascadia Code | `--font-monospace-theme` |

Para gerar de novo o snippet de fontes a partir do Google Fonts:

```bash
bun obsidian/scripts/build-font-snippet.ts
```

Os avisos de copyright das quatro famílias estão em [`snippets/FONTS.md`](snippets/FONTS.md).

## Brilho

`--ardentia-brilho` vai de `0` a `2`, com `1` como o desenho original. Dois limites vêm do próprio Obsidian: o cursor comum do editor é o nativo do navegador e aceita cor, mas não sombra, e o grafo é desenhado em canvas e também não aceita halo por CSS.

## Cofres de demonstração

`demo/` é um cofre com as notas dos quadros do design (Ardentia, Paleta, Tipografia, Layout, Elementos) e o tema ligado por links simbólicos. Abra a pasta como cofre para ver cada elemento e editar o `theme.css` com resultado imediato. `demo-en/` é o mesmo cofre em inglês. No Windows, clone com links simbólicos habilitados ou use o `install.sh`.

## Notas de implementação

- Os rótulos das barras laterais ("Cofre", "Sumário", "Grafo local") vêm de variáveis `--ardentia-rotulo-*`, em português quando o Obsidian está em português e em inglês nos demais idiomas. O Obsidian não expõe o nome da vista dentro do painel.
- Os botões de cada vista lateral, o ícone do tipo de propriedade e o "Adicionar propriedade" ficam ocultos em repouso e aparecem com o mouse, para a nota e as ilhas ficarem como no desenho sem perder função.
- O rótulo da linguagem no bloco de código em modo leitura depende de uma regra por linguagem. As mais comuns estão cobertas.
- Com a janela translúcida ligada, só o abismo deixa o fundo passar. As ilhas continuam opacas.
- As setas de voltar e avançar ficam sempre visíveis à esquerda do cabeçalho da nota, antes do caminho.

## Publicação

Uma tag no formato `x.y.z`, igual à `version` do `manifest.json` da raiz, dispara [o workflow de release](../.github/workflows/release-obsidian.yml), que anexa `manifest.json` e `theme.css` a um release do GitHub. O Obsidian baixa o tema desse release. Tags de outros aplicativos levam prefixo, como `zed-1.0.0`.
