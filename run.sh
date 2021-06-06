#!/bin/sh

docker build -t crafter-bot:latest .

docker run -it --rm crafter-bot:latest
