import { danger, warn, fail } from "danger";
import fs from "fs";

(async () => {
  const files = danger.git.modified_files.concat(danger.git.created_files);

  // Large PR warning
  if (danger.github.pr.additions + danger.github.pr.deletions > 500) {
    warn("⚠️ Large PR — consider splitting");
  }

  // lib changes without tests
  if (files.some(f => f.startsWith("lib/")) && !files.some(f => f.startsWith("test/"))) {
    warn("🧪 Changes in lib/ without tests");
  }

  // TODO / FIXME detection (FIXED)
  for (const file of files) {
    const diff = await danger.git.diffForFile(file);

    if (!diff || !diff.patch) continue;

    if (/TODO|FIXME/i.test(diff.patch)) {
      warn(`📝 TODO/FIXME found in ${file}`);
    }
  }

  // Unused imports from flutter analyze
  if (fs.existsSync("analyze.log")) {
    const log = fs.readFileSync("analyze.log", "utf8");
    const unused = log.split("\n").filter(l => l.includes("unused_import"));
    if (unused.length > 0) {
      fail(`❌ Unused imports detected:\n\n${unused.join("\n")}`);
    }
  }
})();
