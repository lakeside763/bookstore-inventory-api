FROM alpine:latest

RUN apk add --no-cache python3 py3-pip curl
RUN pip3 install --upgrade pip \
  && pip3 install --no-cache-dir awscli \
  && rm -rf /var/cache/apk/*
RUN curl -Ls -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl

# Set working directory to /action
WORKDIR /action

# Copy action files to the working directory
COPY action.yml run.sh /action/

# Grant execute permissions to run.sh
RUN chmod +x /action/run.sh

# Change ownership of action directory to the non-root user
RUN chown -R actionuser:actionuser /action

# Switch to the non-root user
USER actionuser

# Entrypoint for the action
ENTRYPOINT ["/action/run.sh"]
