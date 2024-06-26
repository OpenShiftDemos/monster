FROM golang AS builder
WORKDIR /go/src/github.com/alexellis/href-counter/
RUN go env -w GO111MODULE=auto
COPY ./app.go ./go.mod ./
RUN go get -d -v golang.org/x/net/html
RUN CGO_ENABLED=0 GOOS=linux go build -a -o app .
FROM registry.access.redhat.com/ubi8/ubi-micro
WORKDIR /
COPY --from=builder /go/src/github.com/alexellis/href-counter/app /
EXPOSE 8080
CMD ["./app"]
