FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache python3 py3-pip curl git

# Install AWS CLI
RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir awscli \
    && rm -rf /var/cache/apk/*

# Install kubectl
RUN curl -Ls -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x /usr/bin/kubectl

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh \
    && ./get_helm.sh

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]