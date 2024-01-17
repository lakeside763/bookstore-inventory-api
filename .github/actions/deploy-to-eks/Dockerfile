FROM docker:latest

LABEL "com.github.actions.name"="Build and Deploy"
LABEL "com.github.actions.description"="Builds, tags, and deploys Docker images to ECR, and updates EKS deployment with Helm."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/lakeside763/bookstore-inventory-api"
LABEL "homepage"="https://github.com/lakeside763/bookstore-inventory-api/actions"

# Set working directory to /action
WORKDIR /action
COPY action.yaml run.sh /action/

RUN chmod +x /action/run.sh

ENTRYPOINT ["/action/run.sh"]

