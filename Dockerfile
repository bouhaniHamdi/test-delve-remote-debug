FROM golang:alpine AS build
WORKDIR /
COPY . .
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go mod download
RUN go build -o ./app

FROM alpine:3.9
COPY --from=build /go/bin/dlv /dlv
COPY --from=build /app /app

ENTRYPOINT [ "/dlv" ]