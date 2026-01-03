import { danger, warn, fail, message } from "danger";

(async () => {
/**
 * Collect changed files (new + modified only)
 */
const changedFiles = [
  ...danger.git.modified_files,
  ...danger.git.created_files,
];

if (changedFiles.length === 0) {
  message("No files changed in this PR");
  return;
}

/**
 * Scope files
 */
const dartFiles = changedFiles.filter(f => f.endsWith(".dart"));
const libFiles  = changedFiles.filter(f => f.startsWith("lib/"));
const testFiles = changedFiles.filter(f => f.startsWith("test/"));

/**
 * ----------------------------------------
 * 1️⃣ Skip checks if no Dart files changed
 * ----------------------------------------
 */
if (dartFiles.length === 0) {
  message("No Dart files changed — skipping Flutter checks");
  return;
}

/**
 * ----------------------------------------
 * 2️⃣ Warn if Flutter code changed without tests
 * ----------------------------------------
 */
if (libFiles.length > 0 && testFiles.length === 0) {
  warn("Flutter code changed under `lib/` without updating tests");
}

/**
 * ----------------------------------------
 * 3️⃣ TODO / FIXME check (ONLY newly added lines)
 * ----------------------------------------
 */
for (const file of dartFiles) {
  const diff = await danger.git.diffForFile(file);

  if (!diff?.added) continue;

  if (/TODO|FIXME/.test(diff.added)) {
    warn(`📝 TODO/FIXME added in ${file}`);
  }
}

/**
 * ----------------------------------------
 * 4️⃣ Block very large PRs
 * ----------------------------------------
 */
const MAX_FILES = 100;
if (changedFiles.length > MAX_FILES) {
  warn(
    `Large PR detected (${changedFiles.length} files changed). ` +
    `Consider splitting into smaller PRs.`
  );
}

/**
 * ----------------------------------------
 * 5️⃣ Prevent direct changes to generated files
 * ----------------------------------------
 */
const generatedFiles = changedFiles.filter(f =>
  f.endsWith(".g.dart") || f.endsWith(".freezed.dart")
);

if (generatedFiles.length > 0) {
  warn(
    "Generated files detected (`.g.dart`, `.freezed.dart`). " +
    "Ensure they are auto-generated and not manually edited."
  );
}

// Unused imports from flutter analyze
/**
 * ----------------------------------------
 * 6️⃣ Unused imports check
 * ----------------------------------------
 */
if (fs.existsSync("analyze.log")) {
  const log = fs.readFileSync("analyze.log", "utf8");
  const unused = log.split("\n").filter(l => l.includes("unused_import"));
  if (unused.length > 0) {
    fail(`❌ Unused imports detected:\n\n${unused.join("\n")}`);
  }
}

/**
 * ----------------------------------------
 * 8️⃣ Final summary
 * ----------------------------------------
 */
  message(`Checked ${dartFiles.length} Dart file(s) out of ${changedFiles.length} changed file(s).`);
})();
