# Build Geth in a stock Go builder container
FROM golang:1.12-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /go-ethereum
RUN chmod 755 /go-ethereum/build/env.sh
RUN cd /go-ethereum && make egem

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-ethereum/build/bin/egem /usr/local/bin/geth-egem

EXPOSE 8895 30666 30666/udp
ENTRYPOINT ["geth-egem"]
