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
      hugo \
      nodejs \
      nodejs-dev \
      npm \
      openssh-client \
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

# Install denv
ADD bin/denv /usr/local/bin

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
