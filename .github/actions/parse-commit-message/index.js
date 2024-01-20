const core = require('@actions/core');
const github = require('@actions/github');

try {
  // Define your commit message prefixes here
  const validPrefixes = ['chore', 'feat!', 'feat', 'fix, docs, refactor, perf, styles']; // Add more prefixes as needed

  const commitMessage = github.context.payload.head_commit.message;
  console.log(`Commit Message: ${commitMessage}`);

  // Extract the prefix using a regular expression
  const match = commitMessage.match(/^(\w+):/);
  console.log('Match', match);
  
  if (match) {
    const extractedPrefix = match[1].toLowerCase();
    const incrementType = getVersionIncrementType(extractedPrefix);

    // Check if the extracted prefix is valid
    if (validPrefixes.includes(extractedPrefix)) {
      core.setOutput('extracted_value', incrementType);
    } else {
      core.setFailed(`Invalid prefix: ${extractedPrefix}`);
    }
  } else {
    core.setFailed(`No match found for prefix in commit message`);
  }
} catch (error) {
  core.setFailed(error.message);
}

function getVersionIncrementType(commitPrefix) {
  switch(commitPrefix) {
    case 'feat!':
      return 'major';
    case 'feat':
      return 'minor'
    default: 
      return 'patch'
  }
}