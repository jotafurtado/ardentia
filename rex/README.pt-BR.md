# Ardentia para o Rex

<a href="README.md">English</a> · <b>Português</b>

Referência do porte para o Rex. A visão geral, a paleta e os princípios estão no [README principal](../README.pt-BR.md). O Rex importa tema no formato do Ghostty, então `Ardentia` é o [tema do Ghostty](../ghostty/README.pt-BR.md) com outro comentário de cabeçalho. As cores são as mesmas. Importado pela interface do Rex Beta 0.1.0.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `Ardentia` | O tema. Um arquivo no formato do Ghostty, só com chaves de cor |
| `install.sh` | Importa o tema no Rex pelo CLI |

## Instalar com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/rex/install.sh
```

O script roda `rex do client.theme.import`. O Rex guarda tema importado nas próprias preferências, sem pasta de temas, então o script não copia nada. Importar duas vezes pode adicionar o tema duas vezes.

O CLI só funciona com o Remote Control ligado (Settings, Rex Server). Com ele desligado, o script imprime o caminho do arquivo e os passos manuais. Se houver mais de um app Rex conectado, defina `REX_CLIENT` com o rótulo ou o ID que `rex client ls` mostra:

```bash
REX_CLIENT="meu-mac" ./ardentia/rex/install.sh
```

O script não liga o Remote Control, não troca o tema ativo e não edita o `init.lua`.

## Instalar à mão

No Rex, abra Settings, Themes, Import Theme e escolha o arquivo `Ardentia` desta pasta.

## Ativar

Em Settings, Themes, Dark Mode, selecione Ardentia. Ou, com o Remote Control ligado:

```bash
rex do client.theme.change name=Ardentia
```

Para tingir a interface com as cores do tema, ligue Tint with Theme em Settings, Interface, Appearance (canal Bleeding Edge).

## Notas do porte

- As 16 cores e as demais chaves são as da [referência do Ghostty](../ghostty/README.pt-BR.md).
- `split-divider-color` e `unfocused-split-fill` são chaves do Ghostty. O Rex provavelmente as ignora, e isso não foi testado. O destaque do painel ativo é uma configuração do Rex (Settings, Interface, Active Pane).
- `scripts/check-themes.ts` confere este arquivo com as mesmas regras do arquivo do Ghostty.
