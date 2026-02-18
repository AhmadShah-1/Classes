// teach.js
// Usage: node teach.js [--root "<path to vault>"] [--model "openai:gpt-4o-mini"|"anthropic:claude-3-5-sonnet"] [--dry]
// Requires: Node 18+, `npm i glob fs-extra gray-matter`
import fs from "fs-extra";
import path from "path";
import { glob } from "glob";
import matter from "gray-matter";

// ------------------ CONFIG ------------------
const args = process.argv.slice(2).join(" ");
const ROOT_DIR = (args.match(/--root\s+"([^"]+)"/)?.[1]) || process.cwd();
const MODEL    = (args.match(/--model\s+"([^"]+)"/)?.[1]) || "openai:gpt-4o-mini"; // or "anthropic:claude-3-5-sonnet"
const DRY_RUN  = args.includes("--dry");
const IMAGES_DIR = resolveImagesDir();

// Provide one of these (or both) via environment:
const OPENAI_API_KEY   = process.env.OPENAI_API_KEY || "";
const ANTHROPIC_API_KEY= process.env.ANTHROPIC_API_KEY || "";

// Which file types to ingest as "lectures"
const LECTURE_EXTS = new Set([".md", ".txt", ".pdf"]); // (PDF handled as "text placeholder"; see note below)

// Per-call token budget hint (adjust to your content size)
const MAX_CHARS = 35_000;

// ------------------ LLM CALLS ------------------
async function callLLM({model, system, user}) {
  if (model.startsWith("openai:")) {
    if (!OPENAI_API_KEY) throw new Error("Missing OPENAI_API_KEY");
    const m = model.split(":")[1];
    const r = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${OPENAI_API_KEY}`,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        model: m,
        messages: [{role:"system", content:system},{role:"user", content:user}],
        temperature: 0.2
      })
    });
    const j = await r.json();
    if (!r.ok) throw new Error(JSON.stringify(j, null, 2));
    return j.choices[0].message.content;
  } else if (model.startsWith("anthropic:")) {
    if (!ANTHROPIC_API_KEY) throw new Error("Missing ANTHROPIC_API_KEY");
    const m = model.split(":")[1];
    const r = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "x-api-key": ANTHROPIC_API_KEY,
        "anthropic-version":"2023-06-01",
        "Content-Type":"application/json"
      },
      body: JSON.stringify({
        model: m,
        max_tokens: 4096,
        system,
        messages: [{role:"user", content:user}],
        temperature: 0.2
      })
    });
    const j = await r.json();
    if (!r.ok) throw new Error(JSON.stringify(j, null, 2));
    // Claude returns content as array of blocks
    return j.content.map(b => b.text ?? "").join("\n");
  } else {
    throw new Error("Unknown model provider");
  }
}

// ------------------ HELPERS ------------------
function trimForTokens(text) {
  if (text.length <= MAX_CHARS) return text;
  // naive trim: keep head & tail
  const head = text.slice(0, Math.floor(MAX_CHARS*0.6));
  const tail = text.slice(-Math.floor(MAX_CHARS*0.3));
  return head + "\n\n[...truncated...]\n\n" + tail;
}

async function readLectureFile(fullPath) {
  const ext = path.extname(fullPath).toLowerCase();
  if (ext === ".pdf") {
    // Minimal: we can’t parse PDFs here. Send a placeholder so the LLM knows.
    // For best results, pre-convert PDFs to MD/TXT using your favorite tool (e.g., "obsidian-ocr" plugin or external CLI).
    return `This is a PDF lecture at ${fullPath}. The content is not extracted here. Summarize and produce teaching material based on filename/topic cues if possible.`;
  }
  const raw = await fs.readFile(fullPath, "utf8");
  return inlineEmbeddedImages(raw, path.dirname(fullPath));
}

function isLectureFolder(dir) {
  return path.basename(dir).toLowerCase() === "lecture";
}

function normalizeTopic(t) {
  return t.trim().toLowerCase().replace(/\s+/g, " ");
}

function makeTeachName(baseName) {
  // "lecture 1.md" -> "lecture 1 - teach.md"
  const ext = path.extname(baseName);
  const name = baseName.slice(0, baseName.length - ext.length);
  return `${name} - teach.md`;
}

function resolveImagesDir() {
  const explicit = args.match(/--images\s+"([^"]+)"/);
  if (explicit) {
    const dir = path.resolve(explicit[1]);
    if (fs.existsSync(dir) && fs.statSync(dir).isDirectory()) {
      return dir;
    }
    console.warn(`Images directory provided but missing: ${dir}`);
  }

  const fallback = path.resolve(ROOT_DIR, "..", "..", "Images");
  if (fs.existsSync(fallback) && fs.statSync(fallback).isDirectory()) {
    return fallback;
  }

  console.warn("No images directory found. Embedded Obsidian images will remain as links.");
  return null;
}

function inlineEmbeddedImages(markdown, lectureDir) {
  if (!IMAGES_DIR) return markdown;

  const cache = new Map();
  const embedRE = /!\[\[([^\]|]+)(?:\|[^\]]*)?\]\]/g;

  return markdown.replace(embedRE, (_, target) => {
    const cleaned = target.trim();
    const { fileName, alias } = parseEmbedTarget(cleaned);
    const candidatePaths = [
      path.resolve(lectureDir, fileName),
      path.resolve(IMAGES_DIR, fileName)
    ];

    let imgPath;
    for (const candidate of candidatePaths) {
      if (fs.existsSync(candidate) && fs.statSync(candidate).isFile()) {
        imgPath = candidate;
        break;
      }
    }

    if (!imgPath) {
      console.warn(`Embedded image not found: ${cleaned}`);
      return `![Missing image: ${cleaned}](missing-image.png)`;
    }

    if (!cache.has(imgPath)) {
      const buf = fs.readFileSync(imgPath);
      const mime = guessMimeFromExt(path.extname(imgPath));
      const data = buf.toString("base64");
      cache.set(imgPath, { mime, data });
    }

    const { mime, data } = cache.get(imgPath);
    const caption = alias || fileName;
    return `![${caption}](data:${mime};base64,${data})`;
  });
}

function guessMimeFromExt(ext) {
  switch (ext.toLowerCase()) {
    case ".png":
      return "image/png";
    case ".jpg":
    case ".jpeg":
      return "image/jpeg";
    case ".gif":
      return "image/gif";
    case ".webp":
      return "image/webp";
    default:
      return "application/octet-stream";
  }
}

function parseEmbedTarget(target) {
  const pipeIndex = target.indexOf("|");
  if (pipeIndex === -1) {
    return { fileName: target, alias: null };
  }
  const fileName = target.slice(0, pipeIndex).trim();
  const alias = target.slice(pipeIndex + 1).trim() || null;
  return { fileName, alias };
}

// ------------------ CORE ------------------
async function main() {
  console.log(`Root: ${ROOT_DIR}`);
  const lectureDirs = (await glob("**/Lecture", {cwd: ROOT_DIR, nodir:false, dot:false, follow:true, withFileTypes:false}))
    .map(p => path.resolve(ROOT_DIR, p))
    .filter(p => fs.existsSync(p) && fs.statSync(p).isDirectory());

  if (lectureDirs.length === 0) {
    console.log("No Lecture folders found.");
    return;
  }

  for (const lectureDir of lectureDirs) {
    const classDir = path.dirname(lectureDir);
    const className = path.basename(classDir);
    const aiTeachDir = path.join(lectureDir, "AI_teach");
    if (!DRY_RUN) await fs.ensureDir(aiTeachDir);

    // collect lecture files
    const files = (await fs.readdir(lectureDir))
      .filter(f => f !== "AI_teach")
      .filter(f => LECTURE_EXTS.has(path.extname(f).toLowerCase()));

    const topicMap = {}; // topic -> array of lesson links

    for (const file of files) {
      const full = path.join(lectureDir, file);
      const base = path.basename(file);
      const lectureContent = await readLectureFile(full);
      const trimmed = trimForTokens(lectureContent);

      const system = `You are an expert teaching assistant who analyzes lecture materials and creates detailed, structured teaching notes. Focus on extracting and explaining the actual content shown in images, mathematical examples, equations, and concepts in the exact order they appear.`;
      const user = `
You will receive (a) the class name, (b) the lecture filename, and (c) the lecture content with embedded images.

CRITICAL INSTRUCTIONS:
1) ANALYZE ALL EMBEDDED IMAGES carefully - they contain the actual lecture content (slides, handwritten notes, equations, diagrams)
2) FOLLOW THE EXACT ORDER of content as it appears in the original material
3) For each concept/topic that appears:
   - Define key terms and vocabulary as they're introduced
   - Explain mathematical equations step-by-step in text form
   - Show how variables are expanded or manipulated
   - Describe any diagrams, charts, or visual elements
4) For mathematical examples:
   - Write out the problem statement
   - Show each step of the solution process in detail
   - Explain the reasoning behind each step
   - Provide the final answer with units if applicable

STRUCTURE your teaching note as:
- Title (H1) based on actual content
- Overview of topics covered (in order of appearance)
- Detailed walkthrough following the original sequence:
  - Key terms and definitions
  - Concepts and principles
  - Mathematical examples with step-by-step solutions
  - Important formulas and their applications
- Summary of main points
- Practice problems (if any were shown)

Return format:

<JSON>
{"title":"...", "topics":["specific topic 1","specific topic 2",...]}
</JSON>

<MARKDOWN>
# Title based on actual content
...detailed content following original structure...
</MARKDOWN>

--- INPUT ---
Class: ${className}
Lecture file: ${base}

<LECTURE_CONTENT>
${trimmed}
</LECTURE_CONTENT>
`;

      console.log(`Processing: ${className} / ${base}`);
      const out = await callLLM({model: MODEL, system, user});

      // parse JSON header + Markdown body
      const jsonMatch = out.match(/<JSON>\s*([\s\S]*?)\s*<\/JSON>/i);
      const mdMatch   = out.match(/<MARKDOWN>\s*([\s\S]*?)\s*<\/MARKDOWN>/i);

      if (!jsonMatch || !mdMatch) {
        console.warn(`LLM output parse failed for ${base}. Skipping.`);
        continue;
      }

      let meta;
      try {
        meta = JSON.parse(jsonMatch[1]);
      } catch (e) {
        console.warn(`JSON parse error for ${base}:`, e.message);
        continue;
      }

      const teachMd = mdMatch[1].trim();
      const teachName = makeTeachName(base);
      const teachPath = path.join(aiTeachDir, teachName);

      if (!DRY_RUN) {
        const frontmatter = matter.stringify(teachMd, {
          source_lecture: base,
          class: className,
          topics: meta.topics || [],
          generated: true,
          model: MODEL
        });
        await fs.writeFile(teachPath, frontmatter, "utf8");
      }

      // update topic map
      (meta.topics || []).map(normalizeTopic).forEach(t => {
        if (!t) return;
        const rel = `[[${path.relative(classDir, teachPath).replace(/\\/g,"/")}]]`;
        topicMap[t] = topicMap[t] || new Set();
        topicMap[t].add(rel);
      });
    }

    // write/update _topics_index.md
    const indexPath = path.join(aiTeachDir, "_topics_index.md");
    if (!DRY_RUN) {
      const lines = [
        `# Topics Index — ${className}`,
        "",
        `> Autogenerated. Each topic lists the teaching notes that cover it.`,
        ""
      ];
      const topics = Object.keys(topicMap).sort();
      for (const t of topics) {
        lines.push(`## ${t}`);
        for (const link of Array.from(topicMap[t])) {
          lines.push(`- ${link}`);
        }
        lines.push("");
      }
      await fs.writeFile(indexPath, lines.join("\n"), "utf8");
    }

    console.log(`Done: ${className} → ${path.relative(ROOT_DIR, aiTeachDir)}`);
  }

  console.log("All done.");
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});
