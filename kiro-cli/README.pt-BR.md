# Ardentia para o Kiro CLI

<a href="README.md">English</a> · <b>Português</b>

Referência do porte do Kiro CLI. Para a visão geral, a paleta e os princípios, comece pelo [README principal](../README.pt-BR.md). O Kiro CLI 3.3.0 não aceita cores próprias: as preferências de tema dele só escolhem entre predefinições fixas. Por isso este porte não traz cores. Ele faz a interface desenhar com as 16 cores do terminal, e a paleta vem de um terminal que já usa o Ardentia. Não há capturas de tela.

## O que há nesta pasta

| Caminho | O que é |
| --- | --- |
| `kiro_cli_theme.json` | As preferências de tema do Kiro CLI, sem base fixa e sem predefinição de prompt, de resposta ou de diff |
| `install.sh` | Grava as preferências na pasta de configurações do Kiro CLI e guarda uma cópia das que estavam lá |

## Requisitos

- O Kiro CLI. O porte foi escrito para a versão 3.3.0.
- Um terminal com o Ardentia, para a paleta aparecer: o porte do [Ghostty](../ghostty/README.pt-BR.md) ou o do [Rex](../rex/README.pt-BR.md). Em qualquer outro terminal a interface fica com as cores daquele terminal.

## Instalação com o script

```bash
git clone https://github.com/jotafurtado/ardentia.git
./ardentia/kiro-cli/install.sh
```

O script grava `kiro_cli_theme.json` em `~/.kiro/settings/`, ou em `$KIRO_HOME/settings/` quando essa variável está definida. Para mandar o arquivo para outro lugar, defina `KIRO_SETTINGS_DIR`. Se já existe ali um `kiro_cli_theme.json` diferente, o script guarda antes uma cópia dele na mesma pasta, com o nome `kiro_cli_theme.json.bak-` seguido da data e da hora.

O script não edita nenhum arquivo do shell.

## Instalação à mão

Copie `kiro_cli_theme.json` desta pasta para a pasta de configurações do Kiro CLI. Se você já escolheu um tema no Kiro CLI, guarde antes uma cópia do arquivo que está lá:

```bash
cp ardentia/kiro-cli/kiro_cli_theme.json ~/.kiro/settings/kiro_cli_theme.json
```

## Ativação

Ponha esta linha no arquivo de configuração do seu shell, `~/.zshrc` ou `~/.bashrc`:

```bash
export KIRO_TERMINAL_THEME=safe
```

Abra um terminal novo e inicie o Kiro CLI. Para voltar atrás, tire a linha e ponha de novo a sua cópia de `kiro_cli_theme.json`, ou escolha um tema nas configurações do Kiro CLI.

Se depois você escolher o tema escuro ou o claro nas configurações do Kiro CLI, ele grava essa escolha em `kiro_cli_theme.json`, e a escolha vence a variável.

## O que muda

Com `KIRO_TERMINAL_THEME=safe`, o Kiro CLI usa o tema `safe` dele, que pede cores ao terminal pelo nome em vez de fixar as suas. A tabela mostra o que cada parte recebe e o que isso é num terminal com o Ardentia.

| Parte da interface | Cor do terminal | Num terminal com o Ardentia |
| --- | --- | --- |
| Texto | Padrão | Texto |
| Links, funções no código | Azul | Maré |
| Acento, palavras-chave no código | Magenta | Anêmona |
| Informação, variáveis no código | Ciano | Ardentia |
| Sucesso, linhas adicionadas no diff | Verde | Sargaço |
| Aviso, textos no código | Amarelo | Lanterna |
| Erro, linhas removidas no diff | Vermelho | Coral |
| Marca, números no código | Magenta claro | Água-viva |
| Realce | Azul claro | Maré clara |
| Comentários no código | Preto claro | Tênue |

Duas partes ficam com as cores do Kiro CLI em todo tema, inclusive neste: o mascote da tela inicial e o painel de uso de contexto.

## Notas do porte

- O arquivo de tema do Kiro CLI 3.3.0 tem quatro campos: `baseTheme`, `promptPreset`, `responsePreset` e `diffPreset`. Cada um escolhe numa lista fixa, e nenhuma lista tem cor da paleta. Por isso o porte deixa os quatro de fora.
- `baseTheme` só aceita `dark` e `light`. O tema `safe` é pedido pela variável `KIRO_TERMINAL_THEME`, e um `baseTheme` gravado no arquivo vence a variável. É por isso que o arquivo do porte não tem `baseTheme`.
- Sem a variável, o Kiro CLI tenta descobrir se o terminal é escuro ou claro e usa o tema escuro ou o claro dele, de cores fixas.
- O mascote da tela inicial e as seis faixas do painel de uso de contexto têm cor fixa nos três temas do Kiro CLI. O porte não tem como mudá-los.
- Tudo isso foi lido no código da interface do Kiro CLI 3.3.0. Uma versão mais nova pode mudar o arquivo, a variável ou os temas.
- O porte não tem cores próprias, então `scripts/check-themes.ts` não o confere.
