FROM golang:latest

RUN apt update && apt upgrade -y && \
    apt install -y git \
    make openssh-client

WORKDIR /service
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/air-verse/air@latest

EXPOSE 8001
ENV GOTRACEBACK=all

COPY .air.toml /service/.air.toml
COPY go.mod ./go.mod
COPY go.sum ./go.sum
RUN go mod download
COPY ./cmd /service/cmd
COPY ./config /service/config
COPY ./internal /service/internal
COPY ./server /service/server
CMD ["air", "-c", ".air.toml"]  
