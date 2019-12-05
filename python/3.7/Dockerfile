FROM denv/base

ARG GITHUB_USERNAME

USER root

# Install Python
RUN apk add --update \
    python3 \
    python3-dev

USER $GITHUB_USERNAME
