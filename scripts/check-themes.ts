// Confere os temas dos portes (Zed, VS Code, Ghostty, herdr, Rex, Powerlevel10k) contra o
// contrato de porte: toda cor pertence à paleta, as 16 cores ANSI são as do contrato, nos
// portes que as definem, e as cópias de LICENSE são idênticas à da raiz. A paleta e a tabela
// ANSI abaixo foram copiadas do contrato.
// Uso: bun scripts/check-themes.ts [--root <pasta>]

import { dirname, join, resolve } from "node:path";
import { parseArgs } from "node:util";

const PALETTE: Record<string, string> = {
  abismo: "#0b0d1a",
  fundo: "#101326",
  nota: "#161a30",
  relevo: "#1d2240",
  borda: "#272d52",
  "borda-forte": "#3a4273",
  texto: "#dde2fa",
  suave: "#a8b0db",
  tenue: "#8791c2",
  ardentia: "#4de8d8",
  "agua-viva": "#ff7ac6",
  anemona: "#b9a0ff",
  mare: "#7cb2ff",
  sargaco: "#b4ee7c",
  lanterna: "#ffcc70",
  estrela: "#ffa26b",
  coral: "#ff7383",
  "ardentia-clara": "#8ff5ea",
  "mare-clara": "#a9ccff",
  "lanterna-clara": "#ffe2a8",
  "base-40": "#4a5388",
  sombra: "#04050c",
};
const PALETTE_COLORS = new Set(Object.values(PALETTE));

// Derivada "selecao": ardentia a 24% sobre nota, já misturada para os formatos sem alfa.
const SELECTION_COLOR = "#234b58";

const ANSI_COLORS: readonly string[] = [
  "#1d2240", // 0 black: relevo
  "#ff7383", // 1 red: coral
  "#b4ee7c", // 2 green: sargaco
  "#ffcc70", // 3 yellow: lanterna
  "#7cb2ff", // 4 blue: mare
  "#b9a0ff", // 5 magenta: anemona
  "#4de8d8", // 6 cyan: ardentia
  "#a8b0db", // 7 white: suave
  "#8791c2", // 8 bright black: tenue
  "#ff7383", // 9 bright red: coral
  "#b4ee7c", // 10 bright green: sargaco
  "#ffe2a8", // 11 bright yellow: lanterna-clara
  "#a9ccff", // 12 bright blue: mare-clara
  "#ff7ac6", // 13 bright magenta: agua-viva
  "#8ff5ea", // 14 bright cyan: ardentia-clara
  "#dde2fa", // 15 bright white: texto
];
const ANSI_NAMES = ["Black", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"] as const;

// #rgb fica de fora de propósito: o contrato pede a cor por extenso.
const HEX_PATTERN = /^#(?:[0-9a-f]{6}|[0-9a-f]{8})$/i;

// As únicas chaves que o tema do Ghostty pode definir.
const GHOSTTY_COLOR_KEYS: readonly string[] = [
  "background",
  "foreground",
  "cursor-color",
  "cursor-text",
  "selection-background",
  "selection-foreground",
  "palette",
  "split-divider-color",
  "unfocused-split-fill",
];

// Tokens de [theme.custom] no herdr de terminal 0.9.5.
const HERDR_TOKENS: readonly string[] = [
  "accent",
  "panel_bg",
  "sidebar_bg",
  "active_row_bg",
  "selection_bg",
  "surface0",
  "surface1",
  "surface_dim",
  "overlay0",
  "overlay1",
  "text",
  "subtext0",
  "mauve",
  "green",
  "yellow",
  "red",
  "blue",
  "teal",
  "peach",
];

// O app Herdr recusa o tema sem estas três chaves.
const HERDR_REQUIRED_KEYS: readonly string[] = ["background", "foreground", "selection"];

const LICENSE_COPIES = ["zed/LICENSE", "vscode/LICENSE"];

interface ColorUse {
  path: string;
  value: string;
}

interface AnsiEntry {
  index: number;
  path: string;
  value: string | undefined;
}

interface ParsedTheme {
  colors: ColorUse[];
  ansi: AnsiEntry[];
  // Defeitos que não são de cor e não impedem a leitura, já em forma de mensagem.
  problems?: string[];
}

interface ThemeFile {
  path: string;
  allowsAlpha: (colorPath: string) => boolean;
  allowsSelection: boolean;
  hasAnsi: boolean;
  // Lança erro quando o texto não fecha com o formato do arquivo.
  parse: (text: string) => ParsedTheme;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

// Junta toda string que existe abaixo de um valor. Quem chama decide quais delas são cor:
// o critério é o lugar onde a string está, não a cara dela, para "red", "rgb(...)" ou
// um hex sem "#" não passarem sem serem vistos.
function collectStrings(value: unknown, path: string, found: ColorUse[] = []): ColorUse[] {
  if (typeof value === "string") {
    found.push({ path, value });
  } else if (Array.isArray(value)) {
    value.forEach((item: unknown, index) => collectStrings(item, `${path}[${index}]`, found));
  } else if (isRecord(value)) {
    for (const [key, item] of Object.entries(value)) {
      collectStrings(item, path === "" ? key : `${path}.${key}`, found);
    }
  }
  return found;
}

function ansiFromKeys(source: unknown, prefix: string, keyOf: (index: number) => string): AnsiEntry[] {
  const record = isRecord(source) ? source : {};
  return ANSI_COLORS.map((_, index) => {
    const value = record[keyOf(index)];
    return { index, path: prefix + keyOf(index), value: typeof value === "string" ? value : undefined };
  });
}

function parseZed(text: string): ParsedTheme {
  const root: unknown = JSON.parse(text);
  const themes: unknown[] = isRecord(root) && Array.isArray(root.themes) ? root.themes : [];
  if (themes.length === 0) throw new Error("themes ausente ou vazio");

  const colors: ColorUse[] = [];
  const ansi: AnsiEntry[] = [];
  themes.forEach((theme, themeIndex) => {
    const style = isRecord(theme) ? theme.style : undefined;
    const stylePath = `themes[${themeIndex}].style`;

    // Toda string do estilo é cor, menos a aparência do fundo e o estilo de fonte da sintaxe.
    const strings = collectStrings(style, stylePath).filter(
      ({ path }) =>
        path !== `${stylePath}.background.appearance` &&
        !(path.startsWith(`${stylePath}.syntax.`) && path.endsWith(".font_style")),
    );
    colors.push(...strings);
    ansi.push(
      ...ansiFromKeys(
        style,
        `${stylePath}.`,
        (index) => `terminal.ansi.${index < 8 ? "" : "bright_"}${ANSI_NAMES[index % 8].toLowerCase()}`,
      ),
    );
  });
  return { colors, ansi };
}

function parseVscode(text: string): ParsedTheme {
  const root: unknown = JSON.parse(text);
  const theme = isRecord(root) ? root : {};
  const colors = collectStrings(theme.colors, "colors");

  const rules: unknown[] = Array.isArray(theme.tokenColors) ? theme.tokenColors : [];
  rules.forEach((rule, ruleIndex) => {
    const settings = isRecord(rule) && isRecord(rule.settings) ? rule.settings : {};
    for (const key of ["foreground", "background"]) {
      collectStrings(settings[key], `tokenColors[${ruleIndex}].settings.${key}`, colors);
    }
  });

  // Regra semântica é a cor direto ou um objeto cuja cor fica em foreground.
  const semanticRules = isRecord(theme.semanticTokenColors) ? theme.semanticTokenColors : {};
  for (const [selector, rule] of Object.entries(semanticRules)) {
    const path = `semanticTokenColors.${selector}`;
    if (isRecord(rule)) collectStrings(rule.foreground, `${path}.foreground`, colors);
    else collectStrings(rule, path, colors);
  }

  const ansi = ansiFromKeys(
    theme.colors,
    "colors.",
    (index) => `terminal.ansi${index < 8 ? "" : "Bright"}${ANSI_NAMES[index % 8]}`,
  );
  return { colors, ansi };
}

function parseHerdrJson(text: string): ParsedTheme {
  const root: unknown = JSON.parse(text);
  const theme = isRecord(root) ? root : {};
  const list: unknown[] = Array.isArray(theme.ansi) ? theme.ansi : [];

  // O app desserializa ansi como lista de exatamente 16 e exige as três chaves de base.
  const shapeErrors = HERDR_REQUIRED_KEYS.filter((key) => typeof theme[key] !== "string").map(
    (key) => `${key} ausente ou não é string`,
  );
  if (list.length !== ANSI_COLORS.length) {
    shapeErrors.push(`ansi tem ${list.length} itens, o app pede exatamente ${ANSI_COLORS.length}`);
  }
  if (shapeErrors.length > 0) throw new Error(shapeErrors.join("; "));

  const ansi = ANSI_COLORS.map((_, index) => {
    const value = list[index];
    return { index, path: `ansi[${index}]`, value: typeof value === "string" ? value : undefined };
  });
  return { colors: collectStrings(root, ""), ansi };
}

function parseHerdrToml(text: string): ParsedTheme {
  const root: unknown = Bun.TOML.parse(text);
  const custom = isRecord(root) && isRecord(root.theme) ? root.theme.custom : undefined;
  if (!isRecord(custom)) throw new Error("[theme.custom] ausente");

  const problems = HERDR_TOKENS.filter((token) => !(token in custom)).map(
    (token) => `theme.custom.${token} ausente, é um dos ${HERDR_TOKENS.length} tokens do herdr`,
  );
  for (const [key, value] of Object.entries(custom)) {
    if (HERDR_TOKENS.includes(key)) continue;
    const shown = typeof value === "string" ? ` = ${value}` : "";
    problems.push(`theme.custom.${key}${shown} não é um dos ${HERDR_TOKENS.length} tokens do herdr`);
  }

  // O herdr de terminal também aceita cor por nome, rgb() e "reset", que fugiriam da paleta
  // sem serem vistas. Por isso todo valor de [theme.custom] conta como cor e tem de ser hex.
  const colors = collectStrings(root, "").filter(
    ({ path, value }) => value.startsWith("#") || path.startsWith("theme.custom."),
  );
  // O bloco do herdr de terminal não define as 16 cores ANSI.
  return { colors, ansi: [], problems };
}

function splitPair(text: string): [key: string, value: string] | null {
  const separator = text.indexOf("=");
  if (separator < 1) return null;
  return [text.slice(0, separator).trim(), text.slice(separator + 1).trim()];
}

function parseGhostty(text: string): ParsedTheme {
  // O Ghostty aceita cor sem "#" e por nome X11. Aqui o valor de toda chave de cor
  // tem de vir como #rrggbb.
  const colors: ColorUse[] = [];
  const problems: string[] = [];
  const palette = new Map<number, string>();

  text.split(/\r?\n/).forEach((rawLine, lineIndex) => {
    const line = rawLine.trim();
    if (line === "" || line.startsWith("#")) return;

    const pair = splitPair(line);
    if (!pair) throw new Error(`linha ${lineIndex + 1} não tem a forma chave = valor`);
    const [key, value] = pair;
    if (!GHOSTTY_COLOR_KEYS.includes(key)) {
      problems.push(`chave fora da lista de cores: ${key} = ${value}`);
      return;
    }
    if (key !== "palette") {
      colors.push({ path: key, value });
      return;
    }

    const entry = splitPair(value);
    if (!entry || !/^\d+$/.test(entry[0])) {
      throw new Error(`linha ${lineIndex + 1}: palette pede a forma N=#rrggbb`);
    }
    const index = Number(entry[0]);
    colors.push({ path: `palette[${index}]`, value: entry[1] });
    palette.set(index, entry[1]);
  });

  const ansi = ANSI_COLORS.map((_, index) => ({ index, path: `palette[${index}]`, value: palette.get(index) }));
  return { colors, ansi, problems };
}

function parseP10k(text: string): ParsedTheme {
  // O Powerlevel10k aceita cor por número (0 a 255), por nome e em #rrggbb. Aqui toda cor
  // tem de vir em #rrggbb, nos dois lugares em que ela aparece: no valor das opções de cor
  // e dentro de %F{...} e %K{...}. Comentário não conta.
  const colors: ColorUse[] = [];
  const problems: string[] = [];

  text.split(/\r?\n/).forEach((rawLine, lineIndex) => {
    const line = rawLine.trim();
    if (line === "" || line.startsWith("#")) return;
    const where = `linha ${lineIndex + 1}`;

    const option = /^typeset -g (POWERLEVEL9K_[A-Za-z0-9_{},]*(?:FOREGROUND|BACKGROUND|COLOR))=(\S*)/.exec(line);
    if (option) {
      const name = option[1] ?? "";
      const value = (option[2] ?? "").replace(/^'(.*)'$/, "$1");
      // Valor vazio é opção sem cor: fundo transparente, por exemplo.
      if (value !== "") colors.push({ path: `${where}, ${name}`, value });
    }

    for (const match of line.matchAll(/%([FK])\{([^}]*)\}/g)) {
      colors.push({ path: `${where}, %${match[1] ?? ""}`, value: match[2] ?? "" });
    }
    for (const match of line.matchAll(/%\d+[FK]/g)) {
      problems.push(`${where}: ${match[0]} é cor numerada, o porte pede #rrggbb`);
    }
  });

  return { colors, ansi: [], problems };
}

const THEME_FILES: readonly ThemeFile[] = [
  {
    path: "zed/themes/ardentia.json",
    allowsAlpha: () => true,
    allowsSelection: false,
    hasAnsi: true,
    parse: parseZed,
  },
  {
    path: "vscode/themes/ardentia-color-theme.json",
    // O VS Code não aceita transparência em regra de token, só nas cores da interface.
    allowsAlpha: (colorPath) => colorPath.startsWith("colors."),
    allowsSelection: false,
    hasAnsi: true,
    parse: parseVscode,
  },
  {
    path: "ghostty/Ardentia",
    allowsAlpha: () => false,
    allowsSelection: true,
    hasAnsi: true,
    parse: parseGhostty,
  },
  {
    path: "rex/Ardentia",
    allowsAlpha: () => false,
    allowsSelection: true,
    hasAnsi: true,
    parse: parseGhostty,
  },
  {
    path: "herdr/ardentia.json",
    allowsAlpha: () => false,
    allowsSelection: true,
    hasAnsi: true,
    parse: parseHerdrJson,
  },
  {
    path: "herdr/ardentia.toml",
    allowsAlpha: () => false,
    allowsSelection: false,
    hasAnsi: false,
    parse: parseHerdrToml,
  },
  {
    path: "p10k/ardentia.zsh",
    allowsAlpha: () => false,
    allowsSelection: false,
    hasAnsi: false,
    parse: parseP10k,
  },
];
const ANSI_FILE_COUNT = THEME_FILES.filter((file) => file.hasAnsi).length;

function resolveRoot(): string {
  try {
    const { values } = parseArgs({ args: Bun.argv.slice(2), options: { root: { type: "string" } } });
    // Sem esta recusa, "--root=" cairia na raiz do repositório e aprovaria a pasta errada.
    if (values.root === "") throw new Error("--root vazio");
    return values.root === undefined ? dirname(import.meta.dir) : resolve(values.root);
  } catch {
    console.error("uso: bun scripts/check-themes.ts [--root <pasta>]");
    process.exit(1);
  }
}

const ROOT = resolveRoot();
let errorCount = 0;

function fail(file: string, message: string): void {
  errorCount += 1;
  console.error(`erro  ${file}: ${message}`);
}

function describe(error: unknown): string {
  return error instanceof Error ? error.message : String(error);
}

async function readBytes(relativePath: string): Promise<Buffer | null> {
  const file = Bun.file(join(ROOT, relativePath));
  if (!(await file.exists())) {
    fail(relativePath, "arquivo não existe");
    return null;
  }
  try {
    return Buffer.from(await file.arrayBuffer());
  } catch (error) {
    fail(relativePath, `não pôde ser lido: ${describe(error)}`);
    return null;
  }
}

function checkColors(file: ThemeFile, colors: readonly ColorUse[]): void {
  if (colors.length === 0) fail(file.path, "nenhuma cor encontrada");

  for (const { path, value } of colors) {
    const where = `${path} = ${value}`;
    const allowsAlpha = file.allowsAlpha(path);
    if (!HEX_PATTERN.test(value)) {
      fail(file.path, `${where} não é uma cor ${allowsAlpha ? "#rrggbb ou #rrggbbaa" : "#rrggbb"}`);
      continue;
    }
    if (value !== value.toLowerCase()) fail(file.path, `${where} tem letra maiúscula`);
    if (value.length === 9 && !allowsAlpha) fail(file.path, `${where} tem alfa, que não é aceito aqui`);

    const base = value.slice(0, 7).toLowerCase();
    if (PALETTE_COLORS.has(base)) continue;
    if (base !== SELECTION_COLOR) fail(file.path, `${where} não pertence à paleta`);
    else if (!file.allowsSelection) {
      fail(file.path, `${where} é a derivada selecao, aceita só em ghostty/Ardentia e herdr/ardentia.json`);
    }
  }
}

function checkAnsi(file: ThemeFile, ansi: readonly AnsiEntry[]): void {
  for (const { index, path, value } of ansi) {
    const expected = ANSI_COLORS[index];
    // Alfa cheio (ff) é a mesma cor; o Zed costuma escrever assim.
    if (value === expected || value === `${expected}ff`) continue;
    const found = value === undefined ? "ausente" : `= ${value}`;
    fail(file.path, `ANSI ${index}, ${path} ${found}, o contrato pede ${expected}`);
  }
}

let checkedAnsiFiles = 0;
let ansiErrorCount = 0;

for (const file of THEME_FILES) {
  const errorsBefore = errorCount;
  const bytes = await readBytes(file.path);
  if (bytes === null) continue;

  let theme: ParsedTheme;
  try {
    theme = file.parse(bytes.toString("utf8"));
  } catch (error) {
    fail(file.path, `não é legível no seu formato: ${describe(error)}`);
    continue;
  }

  for (const problem of theme.problems ?? []) fail(file.path, problem);
  checkColors(file, theme.colors);

  if (file.hasAnsi) {
    const errorsBeforeAnsi = errorCount;
    checkAnsi(file, theme.ansi);
    checkedAnsiFiles += 1;
    ansiErrorCount += errorCount - errorsBeforeAnsi;
  }

  if (errorCount === errorsBefore) console.log(`ok    ${file.path} (${theme.colors.length} cores)`);
}

// Só aprova quando os quatro portes foram conferidos: tema ausente ou ilegível já saiu como erro acima.
if (checkedAnsiFiles === ANSI_FILE_COUNT && ansiErrorCount === 0) {
  console.log(`ok    ANSI (16 cores iguais ao contrato nos ${ANSI_FILE_COUNT} arquivos)`);
}

const errorsBeforeLicenses = errorCount;
const license = await readBytes("LICENSE");
for (const copy of LICENSE_COPIES) {
  const bytes = await readBytes(copy);
  if (bytes !== null && license !== null && !bytes.equals(license)) {
    fail(copy, "difere de LICENSE da raiz");
  }
}
if (errorCount === errorsBeforeLicenses) {
  console.log(`ok    licenças (${LICENSE_COPIES.join(" e ")} idênticas a LICENSE)`);
}

process.exit(errorCount > 0 ? 1 : 0);
