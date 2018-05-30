FROM alpine:3.6

ENV GOPATH /go
ENV LEGO_VERSION tags/v0.4.1

RUN apk update && apk add --no-cache --virtual run-dependencies ca-certificates && \
    apk add --no-cache --virtual build-dependencies go git musl-dev && \
    go get -u github.com/xenolf/lego 
COPY . ${GOPATH}/src/github.com/xenolf/lego/
RUN cd ${GOPATH}/src/github.com/xenolf/lego/ && \
    go build -o /usr/bin/lego . 

RUN mv /usr/bin/lego /

ENTRYPOINT [ "/usr/bin/lego" ]
