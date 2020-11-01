FROM    ubuntu:20.04

LABEL   description="image contain all needed stuff"


RUN     apt-get update 
RUN     apt-get install -y wget git gcc tar lvm2

RUN     wget -P /tmp https://golang.org/dl/go1.15.3.linux-amd64.tar.gz && \
        tar -C /usr/local -xzf /tmp/go1.15.3.linux-amd64.tar.gz && \
        rm /tmp/go1.15.3.linux-amd64.tar.gz

RUN     mkdir -p proto_3.11.0 && \
	    curl -L -O https://github.com/protocolbuffers/protobuf/releases/download/v3.11.0/protoc-3.11.0-linux-x86_64.zip && \
	    unzip protoc-3.11.0-linux-x86_64.zip -d proto_3.11.0/ && \
	    sudo mv proto_3.11.0/bin/protoc /usr/bin/protoc && \
	    protoc --version; rm -rf proto_3.11.0; rm protoc-* && \
	    go get -u github.com/golang/protobuf/protoc-gen-go@v1.3

RUN     go get sigs.k8s.io/controller-tools/cmd/controller-gen@v0.2.2
