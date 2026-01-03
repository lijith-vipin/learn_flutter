import { danger, warn, fail, message } from "danger";
import fs from "fs";

(async () => {
  if (!fs.existsSync("analyze_output.txt")) {
    message("No flutter analyze output found");
    return;
  }

  const analyzeOutput = fs.readFileSync("analyze_output.txt", "utf8");

  const changedFiles = [
    ...danger.git.modified_files,
    ...danger.git.created_files,
  ].filter(f => f.endsWith(".dart"));

  if (changedFiles.length === 0) {
    message("No Dart files modified — skipping lint checks");
    return;
  }

  const lines = analyzeOutput.split("\n");

  const relevantIssues = [];

  for (const line of lines) {
    for (const file of changedFiles) {
      if (line.includes(file)) {
        relevantIssues.push(line);
      }
    }
  }

  if (relevantIssues.length === 0) {
    message("No lint issues found in modified files ✅");
    return;
  }

  relevantIssues.forEach(issue => {
    warn(`🧹 Flutter lint: ${issue}`);
  });

  fail(`Flutter lint errors found in modified files (${relevantIssues.length})`);
})();
