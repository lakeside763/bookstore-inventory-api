# Base image with essential tools for building, pushing, and deploying
FROM docker:latest

# Labels for GitHub Actions metadata
LABEL "com.github.actions.name"="Build and Deploy"
LABEL "com.github.actions.description"="Builds, tags, and deploys Docker images to ECR, and updates EKS deployment with Helm."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"
LABEL "repository"="https://github.com/lakeside763/bookstore-inventory-api"
LABEL "homepage"="https://github.com/lakeside763/bookstore-inventory-api/actions"

# Set working directory
WORKDIR /action

# Copy action files
COPY action.yaml run.sh /action/

# Grant execute permissions to run.sh
RUN chmod +x /action/run.sh

# Entrypoint for the action
ENTRYPOINT ["/action/run.sh"]

