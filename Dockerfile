# Compile stage
FROM golang:1.17 AS build-env

# Build Delve
RUN go install github.com/go-delve/delve/cmd/dlv@latest

ADD . /dockerdev
WORKDIR /dockerdev

RUN go build -gcflags="all=-N -l" -o /server

# Final stage
FROM debian:buster

EXPOSE 8000 40000

WORKDIR /
COPY --from=build-env /go/bin/dlv /dlv
COPY --from=build-env /server /

CMD ["/dlv", "--listen=:40000", "--continue", "--headless=true", "--api-version=2", "--accept-multiclient", "--log", "exec", "/server"]