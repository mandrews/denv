FROM denv/base

ARG GITHUB_USERNAME

USER root

RUN apk update && \
    apk add --no-cache \
      nodejs \
      nodejs-dev \
      npm

RUN npm install -g npm && \
    npm update && \
    npm -g install \
      browserslist \
      caniuse-lite \
      gatsby-cli \
      typescript

USER $GITHUB_USERNAME
