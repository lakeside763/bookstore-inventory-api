# Base image with essential tools for building, pushing, and deploying
FROM docker:latest

# Install AWS CLI, Docker, Helm, and jq (if needed for your action)
# RUN apt-get update && apt-get install -y \
#     awscli \
#     docker.io \
#     helm \
#     jq

# Create the actionuser group and user, ensuring compatibility
RUN groupadd -r actionuser && \
    adduser -r -g actionuser actionuser

# Set working directory to /action
WORKDIR /action

# Copy action files to the working directory
COPY action.yaml run.sh /action/

# Grant execute permissions to run.sh
RUN chmod +x /action/run.sh

# Change ownership of action directory to the actionuser
RUN chown -R actionuser:actionuser /action

# Switch to the actionuser
USER actionuser

# Entrypoint for the action
ENTRYPOINT ["/action/run.sh"]

