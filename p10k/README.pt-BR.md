# Ardentia para o Powerlevel10k

<a href="README.md">English</a> · <b>Português</b>

Referência do porte do Powerlevel10k. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). O porte é uma configuração completa do Powerlevel10k, carregada no lugar de `~/.p10k.zsh`. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `ardentia.zsh` | A configuração. Apaga toda opção do Powerlevel10k definida antes dela e define as suas, então funciona sozinha |
| `install.sh` | Copia a configuração para junto dos seus arquivos do zsh, com nome próprio |

## Requisitos

- O Powerlevel10k, já instalado e carregado pelo seu `~/.zshrc`. O porte foi escrito para a versão 1.20.0.
- zsh 5.7.1 ou mais novo, para a cor de 24 bits.
- Um terminal com cor de 24 bits.
- Uma fonte de terminal com glifos Nerd Font, para as pontas arredondadas, o separador e os ícones.

## Instalação com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/p10k/install.sh
```

O script copia `ardentia.zsh` para `~/.p10k-ardentia.zsh`, ou para `$ZDOTDIR/.p10k-ardentia.zsh` quando essa variável está definida. Para mandar o arquivo para outro lugar, defina `P10K_ARDENTIA_FILE` com o caminho completo. Ele cria a pasta se faltar e mostra onde pôs o arquivo. O arquivo entra com nome próprio, então o seu `~/.p10k.zsh` fica como está, e o script recusa um destino chamado `.p10k.zsh`.

O script não edita o `~/.zshrc`.

## Instalação à mão

Copie `ardentia.zsh` desta pasta para `~/.p10k-ardentia.zsh`:

```bash
cp ardentia/p10k/ardentia.zsh ~/.p10k-ardentia.zsh
```

## Ativação

No `~/.zshrc`, ache a linha que carrega a configuração do Powerlevel10k:

```zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

Troque por esta:

```zsh
[[ ! -f ~/.p10k-ardentia.zsh ]] || source ~/.p10k-ardentia.zsh
```

Abra um terminal novo, ou rode `exec zsh`. Para voltar atrás, ponha a linha antiga de novo: o `~/.p10k.zsh` continua onde estava.

## Segmentos

O prompt tem duas linhas. A primeira é uma cápsula em Relevo `#1d2240`, com as pontas arredondadas. Os segmentos ficam lado a lado sobre esse fundo, separados por uma seta fina em Borda forte `#3a4273`. A segunda linha é o caractere de prompt, sem fundo. A cor vai no texto, e só onde ela diz alguma coisa.

| Segmento | O que mostra | Cor do texto |
| --- | --- | --- |
| Pasta | A pasta atual. Quando é longa, os trechos do meio encolhem até o menor prefixo único | Maré `#7cb2ff`. Trechos encurtados em Tênue `#8791c2`. As âncoras, que são o primeiro trecho, o último e a raiz de um projeto, em Maré clara `#a9ccff`, negrito |
| Git | `on` e o ramo, depois o que está pendente: `⇣` e `⇡` para commits atrás e à frente do remoto, `*` para stashes, `~` para conflitos, `+` para alterações preparadas, `!` para alterações não preparadas, `?` para arquivos não rastreados. Só dentro de um repositório | Ramo em Anêmona `#b9a0ff`. Atrás e à frente em Ardentia `#4de8d8`. Preparadas em Sargaço `#b4ee7c`. Não preparadas em Lanterna `#ffcc70`. Não rastreados em Maré. Conflitos e operação em curso em Coral `#ff7383`. `on`, stashes e estado ainda em leitura em Tênue |
| Status | `✔` quando o último comando deu certo. `✘` e o código de saída quando falhou | Sargaço quando deu certo, Coral quando falhou |
| Duração | `took` e quanto tempo o último comando levou, a partir de 3 segundos | Tênue |
| Tarefas em segundo plano | Um ícone enquanto há tarefa rodando em segundo plano | Tênue |
| Caractere de prompt | `❯` na segunda linha. Nos modos do vi, `❮`, `V` e `▶` | Ardentia quando o último comando deu certo, Coral quando falhou |

Em terminal estreito o prompt abre mão do que importa menos. Abaixo de 80 colunas somem o segmento do Git, o ícone do status, a duração e as tarefas em segundo plano. Abaixo de 50 colunas a pasta mostra só o último trecho.

Nada é desenhado à direita.

## Notas do porte

- A configuração começou como a que o autor já usava, feita pelo assistente do Powerlevel10k no estilo classic: blocos cinza com pontas angulares e cores da tabela de 256. O que cada segmento mostra, e quando, é o mesmo. O desenho mudou, para seguir o primeiro princípio do tema: o fundo fica quieto e a cor é um aviso.
- A moldura de duas linhas saiu. A segunda linha traz o caractere de prompt, que é o que o prompt transitório já mostrava.
- O arquivo é uma configuração completa, e não uma camada de cores. Ele apaga antes toda opção `POWERLEVEL9K_*`, então um segmento que você tinha ligado no seu arquivo fica desligado aqui. Para trazê-lo de volta, ponha-o em `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` na sua cópia. Um segmento que este arquivo não pinta fica com as cores do Powerlevel10k, que não são da paleta.
- Toda cor é uma das cores da paleta, escrita em `#rrggbb`. `bun scripts/check-themes.ts`, na raiz do repositório, confere isso.
- Relevo mede 1,1:1 sobre Nota, o fundo dos portes do Ghostty e do Rex, então a cápsula é discreta nesses terminais. Toda cor de texto da cápsula mede pelo menos 5:1 sobre Relevo. O caractere de prompt mede 11,3:1 sobre Nota em Ardentia e 6,6:1 em Coral.
- As cores são sequências de escape de 24 bits. Um terminal sem cor de 24 bits as mostra erradas.
- Depois de um segmento sem fundo, o Powerlevel10k troca o texto para preto antes de imprimir um espaço. Esse preto nunca pinta um caractere visível.
- As regras de terminal estreito leem `_p9k__clm`, uma variável interna do Powerlevel10k. Uma versão mais nova pode trocar o nome dela; nesse caso as regras deixam de esconder segmentos.
- O arquivo deixa `POWERLEVEL9K_CONFIG_FILE` sem valor, então o `p10k configure` grava em `~/.p10k.zsh`, como de costume, e não por cima deste arquivo.
- O prompt transitório e o prompt instantâneo ficam ligados, como na configuração de origem. O prompt instantâneo só funciona com o bloco dele no topo do `~/.zshrc`, que o assistente do Powerlevel10k põe ali.
