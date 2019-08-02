FROM golang:1.11
WORKDIR /go/src/github.com/multi-stage3
RUN go get -d -v golang.org/x/net/html  
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
#GITSECURE REMEDIATION 
RUN  apt-get update && apt-get install -y --fix-missing    subversion=1.10.4-1+deb10u1   


FROM alpine:latest  
RUN apk --no-cache add ca-certificates
RUN apk add --update py-pip
RUN pip install django==1.2
#GITSECURE REMEDIATION 
RUN  pip install     Django>=1.8.15  

WORKDIR /root/
COPY --from=0 /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"]  
