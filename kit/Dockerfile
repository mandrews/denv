FROM denv/base

ARG GITHUB_USERNAME

USER root

RUN apk update && \
    apk add --no-cache \
      build-base \
      gettext \
      gcc \
      make \
      nodejs \
      nodejs-dev \
      npm \
      postgresql-client \
      postgresql-dev \
      python3 \
      python3-dev \
      zip

RUN npm install -g npm && \
    npm update && \
    npm -g install \
      typescript

RUN pip3 install --upgrade pip && \
    pip3 install \
      black==21.9b0 \
      jinja2 \
      jinja2-cli \
      pylint

COPY pylintrc /Users/$GITHUB_USERNAME/.pylintrc

# Install Heroku CLI
RUN curl https://cli-assets.heroku.com/install.sh | sh

RUN gcloud -q components install alpha beta bq core gsutil kubectl && \
    gcloud -q components update

USER $GITHUB_USERNAME
