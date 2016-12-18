FROM alpine:latest

MAINTAINER Chris Luo <chris.luo@derivco.se>
# port the idea from https://hub.docker.com/r/nimmis/alpine-golang/~/dockerfile/

RUN apk upgrade --update &&\
   apk add curl && \
   curl -L -o glibc-2.23-r1.apk \
   "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r1/glibc-2.23-r1.apk" && \
   curl -L -o glibc-bin-2.23-r1.apk \
   "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r1/glibc-bin-2.23-r1.apk" && \
   apk add --allow-untrusted glibc-2.23-r1.apk glibc-bin-2.23-r1.apk && \
   rm -f glibc-2.23-r1.apk glibc-bin-2.23-r1.apk && \
   curl https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz | tar xzf - -C / && \
   mv /go /goroot

RUN apk add --update bash && rm -rf /var/cache/apk/*

ENV GOROOT=/goroot \
      GOPATH=/gopath \
      GOBIN=/gopath/bin \
      PATH=${PATH}:/goroot/bin:/gopath/bin
