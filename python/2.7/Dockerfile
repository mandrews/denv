FROM denv/base

ARG GITHUB_USERNAME

USER root

# Install Python
RUN apk add --update \
    python2 \
    python2-dev

USER $GITHUB_USERNAME
