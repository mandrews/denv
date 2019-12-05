FROM denv/base

ARG USER

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

USER $USER

EXPOSE 4000
