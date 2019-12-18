FROM denv/base

ARG GITHUB_USERNAME

USER root

RUN apk update && \
    apk add --no-cache \
      nodejs \
      nodejs-dev \
      npm \
      python3 \
      python3-dev

RUN npm install -g npm && \
    npm update && \
    npm -g install \
      typescript \
      serverless

RUN pip3 install --upgrade pip && \
    pip3 install \
      awscli \
      awscli-local

RUN chown -R $GITHUB_USERNAME /Users/$GITHUB_USERNAME/.npm && \
    chown -R $GITHUB_USERNAME /Users/$GITHUB_USERNAME/.config

USER $GITHUB_USERNAME
