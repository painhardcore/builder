FROM    ubuntu:20.04

LABEL   description="image contains all needed stuff"

RUN     apt-get update && \
        apt-get install -y wget git gcc tar lvm2 curl unzip make apt-transport-https gnupg2 curl apt-utils && \
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
	apt-get update && \
	apt-get install -y kubectl

RUN     wget -P /tmp https://golang.org/dl/go1.15.3.linux-amd64.tar.gz && \
        tar -C /usr/local -xzf /tmp/go1.15.3.linux-amd64.tar.gz && \
        rm /tmp/go1.15.3.linux-amd64.tar.gz && 
ENV     GO111MODULE=on
ENV     GOPATH="/usr/share/go"
ENV     PATH="/usr/local/go/bin:usr/local/go/bin:$GOPATH/bin:$PATH"


	
RUN     wget -O golangci-lint.deb https://github.com/golangci/golangci-lint/releases/download/v1.32.1/golangci-lint-1.32.1-linux-amd64.deb && \
        dpkg -i golangci-lint.deb

RUN     mkdir -p proto_3.11.0 && \
	curl -L -O https://github.com/protocolbuffers/protobuf/releases/download/v3.11.0/protoc-3.11.0-linux-x86_64.zip && \
	unzip protoc-3.11.0-linux-x86_64.zip -d proto_3.11.0/ && \
	mv proto_3.11.0/bin/protoc /usr/bin/protoc && \
	protoc --version && \
	rm -rf  proto_3.11.0 && \
	rm protoc-* && \
	go get github.com/golang/protobuf/protoc-gen-go@v1.3

RUN     go get sigs.k8s.io/controller-tools/cmd/controller-gen@v0.2.2

RUN     wget -O kind https://github.com/painhardcore/builder/releases/download/0.0.1-alpha/kind_v0.8.1 && \
        chmod +x kind && \
        mv kind /usr/bin
