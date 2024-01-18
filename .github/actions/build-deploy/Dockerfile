# Base image with essential tools for building, pushing, and deploying
FROM alpine:latest

# Switch to a non-root user for security (if applicable)
# RUN adduser -D myuser
# USER myuser

# Labels for GitHub Actions metadata
LABEL "com.github.actions.name"="Build and Deploy"
LABEL "com.github.actions.description"="Builds, tags, and deploys Docker images to ECR, and updates EKS deployment with Helm."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"
LABEL "repository"="https://github.com/lakeside763/bookstore-inventory-api"
LABEL "homepage"="https://github.com/lakeside763/bookstore-inventory-api/actions"

# Install essential packages (optimized for Alpine)
RUN apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.19/community/ --allow-untrusted python3-dev
RUN apk add --update --no-cache py3-pip python3-dev groff less docker
RUN pip install awscli

# Copy and configure entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
