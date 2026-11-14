---
tags:
  - tema
  - leitura
---
Tudo o que o Markdown do Obsidian desenha, do link ao bloco de código, no fundo da nota. Parte de [[Ardentia]].

## Links e tags

Link interno para [[Paleta]]

Link externo para [obsidian.md](https://obsidian.md)

Nota que ainda não existe: [[Changelog]]

#tema #tema/teste #leitura

## Ênfase

**Negrito em lanterna**, *itálico em anêmona*, ***os dois juntos***

~~Riscado~~, ==marcação== e `código em linha`

Atalho <kbd>Ctrl</kbd> <kbd>P</kbd> e nota de rodapé[^1]

## Listas

- Primeiro nível, marcador em ardentia
    - Segundo nível, com guia de recuo
        - Terceiro nível

1. Lista numerada
2. Com os números em anêmona

## Tarefas

- [ ] A fazer
- [x] Feita
- [/] Em andamento
- [>] Adiada
- [!] Importante
- [?] Dúvida
- [-] Cancelada

## Callouts

> [!note] Nota
> Fundo a 8% e contorno a 28% da própria cor.

> [!tip] Dica
> Sem barra lateral, o bloco inteiro carrega a cor.

> [!warning] Aviso
> O texto do corpo continua na cor normal.

> [!danger] Perigo
> Coral fica reservado para erro e risco.

> [!success] Sucesso
> Cada tipo traz ícone próprio, além da cor.

> [!question]- Dúvida recolhida
> Callout dobrável.

> [!example] Exemplo
> Anêmona.

> [!quote] Citação
> Tênue.

## Citação

> Ardentia: fosforescência das águas do mar, visível à noite.

## Tabela

| Elemento | Luz       | Variável       |
| -------- | --------- | -------------- |
| Link     | Ardentia  | `--link-color` |
| Tag      | Água-viva | `--tag-color`  |
| Negrito  | Lanterna  | `--bold-color` |

## Bloco de código

```typescript
type Luz = 'ardentia' | 'coral';

interface Onda {
  energia: number;
  luz: Luz;
}

// só brilha o que se move
export const acender = (mar: Onda[]): Onda[] =>
  mar.filter((o) => o.energia > 0);
```

```html
<nota class="brilho" data-mar="42">$mar /onda/g</nota>
```

## Nota incorporada

![[Paleta#Quando a água se move]]

## Linha horizontal

---

## Matemática e imagem

$e^{i\pi} + 1 = 0$

[^1]: A nota de rodapé fica no fim da página.
