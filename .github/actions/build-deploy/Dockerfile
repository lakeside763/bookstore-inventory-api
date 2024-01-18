FROM python:3.8-alpine

RUN apk --no-cache add git curl docker-cli openssl \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir awscli \
    && curl -Ls -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x /usr/bin/kubectl \
    && curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
