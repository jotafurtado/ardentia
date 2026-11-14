<p align="center">
  <img src="assets/banner.pt-BR.png" alt="Ardentia. O brilho que o mar acende à noite, quando o plâncton se agita." width="100%">
</p>

<p align="center">
  <a href="README.md">English</a> · <b>Português</b>
</p>

# Ardentia

Ardentia é o brilho que o mar acende à noite, quando o plâncton se agita na água escura. O tema parte daí: um fundo de abismo, quase preto, e cor só onde existe sinal.

É uma paleta, quatro famílias tipográficas e um punhado de formas, levadas de aplicativo em aplicativo.

| Aplicativo | Situação | Onde |
| --- | --- | --- |
| Obsidian | Disponível | [`obsidian/`](obsidian/) |
| Zed | Planejado | |
| VS Code | Planejado | |
| Ghostty | Planejado | |
| herdr | Planejado | |

## Obsidian

![Ardentia no Obsidian, layout em ilhas](obsidian/screenshots/islands.pt-BR.png)

Tema escuro para o Obsidian 1.6 ou mais novo. Não é uma troca de cores: painéis, abas, barra de status, propriedades, callouts, blocos de código, menus e a janela de configurações foram redesenhados.

- **Três layouts sobre as mesmas cores.** Ilhas flutuantes por padrão, um layout contínuo para quem prefere tudo colado e um layout de foco, que apaga a moldura até o mouse chegar perto.
- **Um espectro de títulos.** Cada nível de título desce uma cor, do rosa Água-viva no H1 ao amarelo Lanterna no H6.
- **Uma fonte para cada trabalho.** Bricolage Grotesque nos títulos, Atkinson Hyperlegible Next na leitura, Geist na interface, Cascadia Code no código.
- **Brilho em um controle só.** Todo halo do tema responde a uma variável, de desligado a dobrado.
- **Sete estados de tarefa**, além de feita e não feita.
- **Feito para funcionar sem rede.** O tema não faz nenhuma requisição.

### Instalação

**Pelo Obsidian**, quando o tema estiver listado no diretório da comunidade: Configurações, Aparência, Temas, Gerenciar, e busque por Ardentia.

**À mão**, que funciona hoje:

1. Baixe `theme.css` e `manifest.json` do [release mais recente](https://github.com/jotafurtado/ardentia/releases/latest).
2. Coloque os dois em `<seu cofre>/.obsidian/themes/Ardentia/`.
3. Em Configurações, Aparência, Temas, escolha Ardentia.

**Pelo script**, que também copia os snippets opcionais:

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/obsidian/install.sh "/caminho/do/cofre"
```

### Layouts

Uma classe no `body` troca a estrutura inteira. As cores não mudam.

| Layout | Classe | O que faz |
| --- | --- | --- |
| Ilhas | padrão, sem classe | Painéis arredondados sobre o abismo, abas em pílula, barra de status em cápsula |
| Contínuo | `.ardentia-continuo` | Estrutura nativa do Obsidian, painéis colados e divisores de 1 px |
| Foco | `.ardentia-foco` | Faixa de ícones, abas, cabeçalho da nota e barra de status apagam até o mouse chegar perto |

| Contínuo | Foco |
| --- | --- |
| ![Layout contínuo](obsidian/screenshots/continuous.pt-BR.png) | ![Layout foco](obsidian/screenshots/focus.pt-BR.png) |

O Obsidian não tem controle nativo para classes do `body`. Com o plugin [Style Settings](https://github.com/mgmeyers/obsidian-style-settings) instalado, a seção Ardentia traz o seletor de layout, o brilho, o respiro entre as ilhas e o raio dos cantos.

### Brilho

Tudo o que é halo ou esfumaçado passa por uma variável só, `--ardentia-brilho`: `0` desliga, `1` é o desenho original, `2` dobra. Ela controla o esfumaçado do abismo (ardentia no alto à direita, anêmona embaixo à esquerda), o halo do ponto de luz da aba ativa e o halo do cursor, quando o editor desenha o próprio cursor.

![Brilho em 0, 1 e 2](obsidian/screenshots/glow-0-1-2.pt-BR.png)

Para comparar sem plugin, ative um dos snippets de [`obsidian/snippets/`](obsidian/snippets/): `ardentia-sem-brilho` deixa em 0, `ardentia-brilho-forte` em 2.

### Fontes

O tema chama as quatro famílias pelo nome e não baixa nada da rede. Elas chegam ao cofre de um destes dois jeitos:

- instaladas no sistema, ou
- pelo snippet `ardentia-fontes`, que traz as quatro embutidas em woff2 variável (latim e latim estendido, cerca de 700 KB). Copie [`obsidian/snippets/ardentia-fontes.css`](obsidian/snippets/ardentia-fontes.css) para `<seu cofre>/.obsidian/snippets/` e ative em Configurações, Aparência, Fragmentos CSS. É o caminho mais simples para cofre sincronizado entre máquinas.

Se faltar alguma família, a pilha cai para Inter, a fonte do sistema e a monoespaçada padrão. O que for escolhido em Configurações, Aparência, Fonte tem prioridade sobre o tema.

### Tarefas

Além de `- [ ]` e `- [x]`, o tema desenha mais cinco estados:

| Sintaxe | Estado |
| --- | --- |
| `- [/]` | em andamento |
| `- [>]` | adiada |
| `- [!]` | importante |
| `- [?]` | dúvida |
| `- [-]` | cancelada |

### Largura da nota e das tabelas

Tema não cria botão. O plugin [Ardentia Largura](https://github.com/jotafurtado/ardentia-width) cria dois: um no cabeçalho da nota, que estica a nota inteira até a largura do painel, e um acima de cada tabela, que estica só aquela tabela. Funciona com qualquer tema.

### Mais

Variáveis, medidas, o cofre de demonstração e as notas de implementação estão em [`obsidian/README.pt-BR.md`](obsidian/README.pt-BR.md).

## Paleta

O mar à noite: seis profundidades, três níveis de texto e oito luzes. Os contrastes foram medidos sobre o fundo da nota.

![Paleta do Ardentia](assets/palette.pt-BR.png)

<details>
<summary>Valores em hexadecimal, prontos para copiar</summary>

| Profundidade | Hex | Uso |
| --- | --- | --- |
| Abismo | `#0B0D1A` | entre as ilhas, barra de título |
| Fundo | `#101326` | barras laterais, bloco de código |
| Nota | `#161A30` | onde se escreve |
| Relevo | `#1D2240` | hover, itens ativos, cápsulas |
| Borda | `#272D52` | divisores, contornos |
| Borda forte | `#3A4273` | modais, caixas de marcação |

| Texto | Hex | Contraste | Uso |
| --- | --- | --- | --- |
| Texto | `#DDE2FA` | 13,3:1 | ler por horas |
| Suave | `#A8B0DB` | 8,1:1 | a interface |
| Tênue | `#8791C2` | 5,6:1 | o que pode esperar |

| Luz | Hex | Contraste | Uso |
| --- | --- | --- | --- |
| Ardentia | `#4DE8D8` | 11,3:1 | acento, links, cursor, H4 |
| Água-viva | `#FF7AC6` | 7,2:1 | H1, tags, palavras-chave |
| Anêmona | `#B9A0FF` | 7,8:1 | H2, itálico, citações |
| Maré | `#7CB2FF` | 7,9:1 | H3, links externos, funções |
| Sargaço | `#B4EE7C` | 12,6:1 | H5, sucesso, strings |
| Lanterna | `#FFCC70` | 11,5:1 | H6, negrito, marcação |
| Estrela | `#FFA26B` | 8,7:1 | avisos, números |
| Coral | `#FF7383` | 6,6:1 | erros, perigo, tags HTML |

</details>

## Tipografia

Quatro famílias livres, todas sob a licença SIL Open Font e disponíveis no Google Fonts. Cada uma tem um trabalho só.

![Tipografia do Ardentia](assets/typography.pt-BR.png)

## Princípios

- O fundo fica quieto. A cor é sempre um aviso.
- Cada nível de título desce um passo no espectro.
- Uma fonte para cada trabalho: titular, ler, operar, codar.

## Licença

[MIT](LICENSE). As fontes embutidas no snippet opcional mantêm a licença própria, a SIL Open Font License 1.1: veja [`obsidian/snippets/FONTS.md`](obsidian/snippets/FONTS.md).
