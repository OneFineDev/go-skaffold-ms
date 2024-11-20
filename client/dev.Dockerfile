FROM golang:latest

RUN apt update && apt upgrade -y && \
    apt install -y git \
    make openssh-client

WORKDIR /app
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/air-verse/air@latest

EXPOSE 3000
ENV GOTRACEBACK=all

COPY .air.toml /app/.air.toml
COPY go.mod ./go.mod
COPY go.sum ./go.sum
RUN go mod download
COPY ./api /app/api
COPY ./cmd /app/cmd
COPY ./pkg /app/pkg
COPY ./internal /app/internal
COPY ./web /app/web
COPY ./main.go /app/main.go
CMD ["air", "-c", ".air.toml"]  
