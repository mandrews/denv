FROM alpine

ARG GITHUB_USERNAME
ARG DEV_DIR

# Install base toolchain
RUN apk update && \
    apk add --no-cache \
      ack \
      asciinema \
      bash \
      curl \
      docker \
      docker-compose \
      git \
      gnupg \
      hugo \
      jq \
      libc6-compat \
      man man-pages mdocml-apropos less less-doc \
      openssh-client \
      py-crcmod \
      python3 \
      sudo \
      tmux \
      vim \
      zsh

RUN mkdir -p /Users && \
    sed -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' -i /etc/sudoers && \
    adduser -S $GITHUB_USERNAME -G root -h /Users/$GITHUB_USERNAME && \
    addgroup $GITHUB_USERNAME wheel

# Install ngrok
RUN curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o /tmp/ngrok.zip && \
    unzip /tmp/ngrok.zip -d /usr/local/bin && \
    rm /tmp/ngrok.zip

# Install shellcheck
ARG SC_VERSION=stable
RUN wget -qO- "https://storage.googleapis.com/shellcheck/shellcheck-${SC_VERSION}.linux.x86_64.tar.xz" | tar -xJv && \
  cp "shellcheck-${SC_VERSION}/shellcheck" /usr/local/bin/

# Install Google Cloud SDK
ARG CLOUD_SDK_VERSION=275.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ENV PATH /google-cloud-sdk/bin:$PATH
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true

# Install AWS CLI
RUN pip3 install --upgrade pip && \
    pip3 install \
      awscli

# Install denv
COPY bin/denv /usr/local/bin

WORKDIR /Users/$GITHUB_USERNAME
USER $GITHUB_USERNAME

# Configure tmux
COPY tmux.conf .tmux.conf

# Configure zsh/oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
COPY zshrc .zshrc

# Configure vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY vimrc .vimrc
RUN echo | echo | vim +PluginInstall +qall &>/dev/null

ENV GITHUB_USERNAME $GITHUB_USERNAME
ENV HOME /Users/$GITHUB_USERNAME
ENV DEV_DIR $DEV_DIR

RUN mkdir -p /Users/$GITHUB_USERNAME/.local && \
    chown -R $GITHUB_USERNAME /Users/$GITHUB_USERNAME/.local

ENV SHELL /bin/zsh
VOLUME /Users/$GITHUB_USERNAME/.local

WORKDIR /Users/$GITHUB_USERNAME/$DEV_DIR

CMD ["/bin/zsh"]
