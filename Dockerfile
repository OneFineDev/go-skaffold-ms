# Build stage
FROM golang:1.23.2-alpine AS build
ENV GOTRACEBACK=all
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
# RUN go install github.com/a-h/templ/cmd/templ@$(go list -m -f '{{ .Version }}' github.com/a-h/templ)
# RUN templ generate
COPY . /app
RUN CGO_ENABLED=0 GOOS=linux go build -o /entrypoint 

# Final stage
FROM scratch
WORKDIR /
ENV GOTRACEBACK=all
COPY --from=build /entrypoint /entrypoint
COPY --from=build /app/web/public/assets/dist /dist
CMD ["./entrypoint"]