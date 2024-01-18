# Base image with essential tools for building, pushing, and deploying
FROM alpine:latest

# Labels for GitHub Actions metadata
LABEL "com.github.actions.name"="Build and Deploy"
LABEL "com.github.actions.description"="Builds, tags, and deploys Docker images to ECR, and updates EKS deployment with Helm."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/lakeside763/bookstore-inventory-api"
LABEL "homepage"="https://github.com/lakeside763/bookstore-inventory-api/actions"

RUN apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.19/community/ --allow-untrusted python3-dev
RUN pip install awscli
RUN pip install docker


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

