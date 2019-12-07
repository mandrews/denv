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
      create-react-app \
      gatsby-cli \
      typescript

RUN chown -R $GITHUB_USERNAME /Users/$GITHUB_USERNAME/.npm && \
    chown -R $GITHUB_USERNAME /Users/$GITHUB_USERNAME/.config

USER $GITHUB_USERNAME
