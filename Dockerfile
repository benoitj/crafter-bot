## Copyright (C) 2021 by Benoit Joly

##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


FROM archlinux:latest
LABEL maintainer="Benoit Joly <benoit@benoitj.ca>"

USER root

RUN pacman --noconfirm -Syu && \
    pacman --noconfirm -S emacs

RUN pacman --noconfirm -S git

RUN useradd -m crafter-bot
#RUN useradd -m -u 9999 -g 9999 crafter-bot

USER crafter-bot

COPY . /home/crafter-bot/bot

ENV BOT_IRC_SERVER="irc.libera.chat" \
    BOT_IRC_PORT="6697" \
    BOT_NICK="crafter-bot" \
    BOT_PASSWORD="" \
    BOT_CHANNEL="#systemcrafters"

VOLUME "/home/crafter-bot/bot"
WORKDIR "/home/crafter-bot/bot"

CMD "emacs" "-l" "/home/crafter-bot/bot/crafter-bot.el"
