FROM golang:1.11
WORKDIR /go/src/github.com/multi-stage3
RUN go get -d -v golang.org/x/net/html  
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .


FROM alpine:latest  
RUN apk --no-cache add ca-certificates
RUN apk add --update py-pip

#RUN pip install django==1.2
pip install django==1.2

WORKDIR /root/
COPY --from=0 /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"]  
