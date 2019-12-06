FROM denv/base

ARG GITHUB_USERNAME

USER root

RUN apk add --update \
    build-base \
    ruby \
    ruby-bigdecimal \
    ruby-dev \
    ruby-etc \
    ruby-rdoc

RUN gem update && \
    gem install jekyll bundler json

USER $GITHUB_USERNAME
