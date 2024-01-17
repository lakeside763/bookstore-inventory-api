# Base image with essential tools for building, pushing, and deploying
FROM alpine:latest

# Install AWS CLI, Docker, Helm, and jq (for parsing JSON outputs)
RUN apt-get update && apt-get install -y \
    awscli \
    docker.io \
    helm \
    jq

# Create a non-root user for security
RUN useradd -ms /bin/bash actionuser

# Set working directory to /action
WORKDIR /action

# Copy action files to the working directory
COPY action.yaml run.sh /action/

# Grant execute permissions to run.sh
RUN chmod +x /action/run.sh

# Change ownership of action directory to the non-root user
RUN chown -R actionuser:actionuser /action

# Switch to the non-root user
USER actionuser

# Entrypoint for the action
ENTRYPOINT ["/action/run.sh"]

