FROM python:3.8-alpine

RUN apk --no-cache add curl \
  && pip3 install --upgrade pip \
  && pip3 install --no-cache-dir awscli \
  && pip3 install --no-cache-dir docker-cli \
  && curl -Ls -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]