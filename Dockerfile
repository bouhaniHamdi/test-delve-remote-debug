FROM golang:1.17 AS build
WORKDIR /
COPY . .
RUN go install github.com/go-delve/delve/cmd/dlv@latest

RUN CGO_ENABLED=0 go build -gcflags "all=-N -l" -o ./app

FROM scratch
COPY --from=build /go/bin/dlv /dlv
COPY --from=build /app /app
ENTRYPOINT [ "/dlv" ]