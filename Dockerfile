FROM clojure
MAINTAINER Antoine Lucas

RUN mkdir -p /home/src
WORKDIR /home/src

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y vim

