FROM golang:1.17 AS build
WORKDIR /
COPY . .
RUN CGO_ENABLED=0  go install github.com/go-delve/delve/cmd/dlv@latest
RUN go mod download
RUN CGO_ENABLED=0 go build -o ./app

FROM alpine:3.9
COPY --from=build /go/bin/dlv /dlv
COPY --from=build /app /app

ENTRYPOINT [ "/dlv" ]