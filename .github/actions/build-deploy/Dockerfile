# Base image with essential tools for building, pushing, and deploying
FROM ubuntu:latest

# Install AWS CLI, Docker, Helm, and jq (for parsing JSON outputs)
# RUN apt-get update && apt-get install -y \
#     awscli \
#     docker.io \
#     helm \
#     jq

# Set working directory to /action
WORKDIR /action

# Copy action files to the working directory
COPY action.yaml run.sh /action/

# Entrypoint for the action
ENTRYPOINT ["/action/run.sh"]