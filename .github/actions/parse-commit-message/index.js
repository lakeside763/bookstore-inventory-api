const core = require('@actions/core');
const github = require('@actions/github');

try {
  const { pattern } = core.getInput();

  console.log('Pattern:', pattern);
  if (!pattern) {
    core.setFailed('Pattern is undefined');
    return;
  }

  const commitMessage = github.context.payload.head_commit.message;
  console.log('Commit Message:', commitMessage);
  if (!commitMessage) {
    core.setFailed('Commit message is undefined');
    return;
  }
  const match = commitMessage.match(pattern);

  if (match) {
    core.setOutput('extracted_value', match[1]); // Assuming the desired value is in the first capture group
  } else {
    core.setFailed(`No match found for pattern: ${pattern}`);
  }
} catch (error) {
  core.setFailed(error.message);
}