// Gera snippets/ardentia-fontes.css: as quatro famílias do tema embutidas em base64,
// para o cofre levar as fontes junto (Syncthing, outro sistema, máquina sem as fontes).
// Uso: bun obsidian/scripts/build-font-snippet.ts

import { mkdir } from "node:fs/promises";
import { dirname, join } from "node:path";

const STYLESHEET_URL =
  "https://fonts.googleapis.com/css2" +
  "?family=Bricolage+Grotesque:opsz,wdth,wght@12..96,75..100,200..800" +
  "&family=Atkinson+Hyperlegible+Next:ital,wght@0,200..800;1,200..800" +
  "&family=Geist:wght@100..900" +
  "&family=Cascadia+Code:ital,wght@0,200..700;1,200..700" +
  "&display=swap";

// O Google só entrega woff2 variável para navegador atual.
const USER_AGENT =
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36";

// Português cabe em latin; latin-ext cobre nomes próprios. symbols2 traz os traços de caixa do código.
const SUBSETS_BY_FAMILY: Record<string, readonly string[]> = {
  "Bricolage Grotesque": ["latin", "latin-ext"],
  "Atkinson Hyperlegible Next": ["latin", "latin-ext"],
  Geist: ["latin", "latin-ext"],
  "Cascadia Code": ["latin", "latin-ext", "symbols2"],
};

interface FontFace {
  subset: string;
  family: string;
  declarations: string;
  url: string;
}

function parseFontFaces(stylesheet: string): FontFace[] {
  const faces: FontFace[] = [];
  const pattern = /\/\*\s*([\w-]+)\s*\*\/\s*@font-face\s*\{([^}]+)\}/g;

  for (const match of stylesheet.matchAll(pattern)) {
    const subset = match[1];
    const body = match[2];
    const family = body.match(/font-family:\s*'([^']+)'/)?.[1];
    const url = body.match(/url\((https:[^)]+)\)/)?.[1];
    if (!subset || !family || !url) continue;

    const declarations = body
      .split(";")
      .map((line) => line.trim())
      .filter((line) => line.length > 0 && !line.startsWith("src:"))
      .join(";\n  ");

    faces.push({ subset, family, declarations, url });
  }

  return faces;
}

async function fetchBase64(url: string): Promise<{ base64: string; bytes: number }> {
  const response = await fetch(url);
  if (!response.ok) throw new Error(`falha ao baixar ${url}: ${response.status}`);
  const buffer = Buffer.from(await response.arrayBuffer());
  return { base64: buffer.toString("base64"), bytes: buffer.byteLength };
}

const response = await fetch(STYLESHEET_URL, { headers: { "User-Agent": USER_AGENT } });
if (!response.ok) throw new Error(`falha ao baixar a folha de fontes: ${response.status}`);

const faces = parseFontFaces(await response.text()).filter((face) =>
  SUBSETS_BY_FAMILY[face.family]?.includes(face.subset),
);

const blocks: string[] = [];
let totalBytes = 0;

for (const face of faces) {
  const { base64, bytes } = await fetchBase64(face.url);
  totalBytes += bytes;
  console.log(`${face.family} (${face.subset}): ${(bytes / 1024).toFixed(0)} KB`);
  blocks.push(
    `/* ${face.family}, ${face.subset} */\n@font-face {\n  ${face.declarations};\n` +
      `  src: url(data:font/woff2;base64,${base64}) format("woff2");\n}`,
  );
}

const header =
  "/* Ardentia: fontes embutidas.\n" +
  "   Bricolage Grotesque, Atkinson Hyperlegible Next, Geist e Cascadia Code (SIL Open Font License),\n" +
  "   em woff2 variável, para o tema sair igual em máquina sem as fontes instaladas.\n" +
  "   Avisos de copyright em FONTS.md e texto da licença em OFL.txt, nesta pasta.\n" +
  "   Arquivo gerado por scripts/build-font-snippet.ts. Não edite à mão. */\n\n";

const outputPath = join(dirname(import.meta.dir), "snippets", "ardentia-fontes.css");
await mkdir(dirname(outputPath), { recursive: true });
await Bun.write(outputPath, header + blocks.join("\n\n") + "\n");

console.log(`${faces.length} faces, ${(totalBytes / 1024).toFixed(0)} KB de fonte, em ${outputPath}`);
