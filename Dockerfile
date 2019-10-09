FROM alpine

ARG USER
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
      openssh-client \
      sudo \
      tmux \
      vim \
      zsh

RUN mkdir -p /Users && \
    sed -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' -i /etc/sudoers && \
    adduser -S $USER -G root -h /Users/$USER && \
    addgroup $USER wheel

WORKDIR /Users/$USER
USER $USER

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

# Configure denv
ENV USER $USER
ENV HOME /Users/$USER
ENV DENV_HOME=$HOME/.denv
ENV DEV_DIR $DEV_DIR
ENV PATH $DENV_HOME/bin:$PATH
ADD . $DENV_HOME

RUN mkdir -p /Users/$USER/.local && \
    chown -R $USER /Users/$USER/.local

ENV SHELL /bin/zsh
VOLUME /Users/$USER/.local

WORKDIR /Users/$USER/$DEV_DIR

CMD ["/bin/zsh"]
