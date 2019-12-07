FROM denv/base

ARG GITHUB_USERNAME

USER root

RUN apk update && \
    apk add --no-cache \
      build-base \
      libxml2-dev \
      nodejs \
      nodejs-dev \
      ruby \
      ruby-bigdecimal \
      ruby-dev \
      ruby-etc \
      ruby-rdoc \
      sqlite-dev \
      tzdata \
      yarn

RUN gem update && \
    gem install \
      bundler \
      jekyll \
      json \
      rails

USER $GITHUB_USERNAME
