FROM archlinux:latest
LABEL maintainer="Benoit Joly <benoit@benoitj.ca>"

RUN pacman --noconfirm -Syu && \
    pacman --noconfirm -S emacs

RUN pacman --noconfirm -S git

RUN useradd -m crafter-bot

USER crafter-bot
COPY . /home/crafter-bot/bot

CMD "emacs" "-l" "/home/crafter-bot/bot/lib/bootstrap.el"
