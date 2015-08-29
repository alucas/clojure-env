FROM clojure
MAINTAINER Antoine Lucas

WORKDIR /root/

RUN apt-get update && apt-get install -y zsh git vim tree screen curl

# Configure VIM
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
RUN cd ~/.vim/bundle && git clone https://github.com/kien/rainbow_parentheses.vim.git
RUN cd ~/.vim/bundle && git clone https://github.com/tpope/vim-fireplace.git

RUN git clone https://github.com/alucas/clojure-test.git

# Configure GIT
RUN git config --global core.editor vim && git config --global user.name "Antoine Lucas" && git config --global user.email "git.alucas@gmail.com"

ADD .zshrc /root/
ADD .vimrc /root/

ENV SHELL=zsh

CMD ["zsh"]
