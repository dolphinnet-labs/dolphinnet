FROM --platform=$BUILDPLATFORM golang:1.22.7-alpine3.20 AS builder

ARG VERSION=v0.0.0

RUN apk add --no-cache make gcc musl-dev linux-headers git jq bash

# build op-node with the shared go.mod & go.sum files
COPY ./fd-node /app/fd-node
COPY ./fd-service /app/fd-service
COPY ./common /app/common
COPY ./fd-supervisor /app/fd-supervisor
COPY ./fd-deployer /app/fd-deployer

COPY ./go.mod /app/go.mod
COPY ./go.sum /app/go.sum

WORKDIR /app/fd-node

RUN go mod tidy

ARG TARGETOS TARGETARCH

RUN go build -o bin/fd-node ./cmd/main.go

FROM alpine:3.21

COPY --from=builder /app/fd-node/bin/fd-node /usr/local/bin

CMD ["fd-node"]
