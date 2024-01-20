const core = require('@actions/core');
const github = require('@actions/github');

try {
  const { pattern } = core.getInputs();
  console.log(pattern)

  const commitMessage = github.context.payload.head_commit.message;
  console.log(commitMessage);
  const match = commitMessage.match(pattern);
  console.log(match);

  if (match) {
    core.setOutput('extracted_value', match[1]); // Assuming the desired value is in the first capture group
  } else {
    core.setFailed(`No match found for pattern: ${pattern}`);
  }
} catch (error) {
  core.setFailed(error.message);
}