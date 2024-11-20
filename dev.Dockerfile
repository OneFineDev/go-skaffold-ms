FROM golang:latest

RUN apt update && apt upgrade -y && \
    apt install -y git \
    make openssh-client

WORKDIR /service
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install github.com/air-verse/air@latest

EXPOSE 80
ENV GOTRACEBACK=all

COPY go.mod ./go.mod
COPY go.sum ./go.sum
RUN go mod download
COPY . ./service
CMD ["air", "-c", ".air.toml"]  
