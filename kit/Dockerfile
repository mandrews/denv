FROM denv/base

ARG GITHUB_USERNAME

USER root

RUN apk update && \
    apk add --no-cache \
      build-base \
      gettext \
      gcc \
      make \
      mongodb-tools \
      nodejs \
      nodejs-dev \
      npm \
      postgresql-client \
      postgresql-dev \
      python3 \
      python3-dev

RUN npm install -g npm && \
    npm update && \
    npm -g install \
      typescript

RUN pip3 install --upgrade pip && \
    pip3 install \
      jinja2

# Install Heroku CLI
RUN curl https://cli-assets.heroku.com/install.sh | sh

RUN gcloud -q components install kubectl

USER $GITHUB_USERNAME
