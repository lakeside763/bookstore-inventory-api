#!/bin/bash

# Get current tag and components
CURRENT_TAG=$(git describe --tags --abbrev=0)
if [[ -z "$CURRENT_TAG" ]]; then
  CURRENT_TAG="v0.0.1"  # Create initial tag if none exists
  git tag $CURRENT_TAG  # Create the tag in the repository
fi

TAG_VERSION="${CURRENT_TAG#v}"

# # Split the version string into components using a period as the delimiter
# IFS=. read -r CURRENT_MAJOR CURRENT_MINOR CURRENT_PATCH <<< "$TAG_VERSION"

CURRENT_MAJOR=$(echo $TAG_VERSION | awk -F. '{print $1}')
CURRENT_MINOR=$(echo $TAG_VERSION | awk -F. '{print $2}')
CURRENT_PATCH=$(echo $TAG_VERSION | awk -F. '{print $3}')

# Determine increment type based on extracted value
INCREMENT_TYPE="${1:-patch}"

# Increment version components accordingly
if [[ $INCREMENT_TYPE == "major" ]]; then
  NEW_MAJOR=$((CURRENT_MAJOR + 1))
  NEW_MINOR=0
  NEW_PATCH=0
elif [[ $INCREMENT_TYPE == "minor" ]]; then
  NEW_MAJOR=$CURRENT_MAJOR
  NEW_MINOR=$((CURRENT_MINOR + 1))
  NEW_PATCH=0
else  # Patch increment
  NEW_MAJOR=$CURRENT_MAJOR
  NEW_MINOR=$CURRENT_MINOR
  NEW_PATCH=$((CURRENT_PATCH + 1))
fi

# Construct new tag
NEW_TAG="v${NEW_MAJOR}.${NEW_MINOR}.${NEW_PATCH}"
NEW_TAG_WITH_NO_V="${NEW_MAJOR}.${NEW_MINOR}.${NEW_PATCH}"

echo ::set-output name=git-tag::$NEW_TAG

# Create and push new tag
git tag $NEW_TAG
git push origin $NEW_TAG

# Commit and push package.json changes
git add package.json
npm version ${INCREMENT_TYPE} -m "$NEW_TAG_NO_V"
git push origin ${GITHUB_REF}