#!/bin/bash

# Fetch remote tags
git fetch --tags

# Get the latest tag after fetching
CURRENT_TAG=$(git describe --tags --abbrev=0)
if [[ -z "$CURRENT_TAG" ]]; then
  CURRENT_TAG="v1.0.0"  # Create initial tag if none exists
  git tag $CURRENT_TAG
fi

TAG_VERSION="${CURRENT_TAG#v}"

# # Split the version string into components using a period as the delimiter
IFS=. read -r CURRENT_MAJOR CURRENT_MINOR CURRENT_PATCH <<< "$TAG_VERSION"

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

echo "current tag - $CURRENT_TAG"
echo "INCREMENT TYPE - $INCREMENT_TYPE"
echo "NEW tag - $NEW_TAG"
echo "NEW tag WITH NO V - $NEW_TAG_WITH_NO_V"

# Create and push new tag
git tag $NEW_TAG
git push origin $NEW_TAG


# # Commit and push package.json changes
# git add package.json
# npm version ${INCREMENT_TYPE} -m "$NEW_TAG_NO_V"
# git commit -m "Update version to $NEW_TAG_NO_V"
# git push origin ${GITHUB_REF}