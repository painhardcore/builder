FROM    ubuntu:20.04

LABEL   description="image contain all needed stuff"


RUN     apt-get update 
RUN     apt-get install -y wget git gcc

RUN wget -P /tmp https://golang.org/dl/go1.15.3.linux-amd64.tar.gz

RUN tar -C /usr/local -xzf /tmp/go1.15.3.linux-amd64.tar.gz
RUN rm /tmp/go1.15.3.linux-amd64.tar.gz
        
