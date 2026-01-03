import { danger, warn, fail } from "danger";
import fs from "fs";

const files = danger.git.modified_files.concat(danger.git.created_files);

// Large PR warning
if (danger.github.pr.additions + danger.github.pr.deletions > 500) {
  warn("⚠️ Large PR — consider splitting");
}

// lib changes without tests
if (files.some(f => f.startsWith("lib/")) && !files.some(f => f.startsWith("test/"))) {
  warn("🧪 Changes in lib/ without tests");
}

// TODO / FIXME
files.forEach(file => {
  const diff = danger.git.diffForFile(file);
  if (diff?.patch?.match(/TODO|FIXME/)) {
    warn(`📝 TODO/FIXME found in ${file}`);
  }
});

// Unused imports (from flutter analyze)
if (fs.existsSync("analyze.log")) {
  const log = fs.readFileSync("analyze.log", "utf8");
  const unused = log.split("\n").filter(l => l.includes("unused_import"));
  if (unused.length > 0) {
    fail(`❌ Sorry Unused imports detected:\n\n${unused.join("\n")}`);
  }
}
