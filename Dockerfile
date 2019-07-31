FROM debian:8.7
WORKDIR /go/src/github.com/alexellis/href-counter/
RUN go get -d -v golang.org/x/net/html  
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
RUN  apt-get update && apt_get install -y --fix-missing    procps=2:3.3.9-9+deb8u1  sensible-utils=0.0.9+deb8u1 \ 
     systemd=215-17+deb8u12  apt=1.0.9.8.5 \ 
     libgcrypt20=1.6.3-2+deb8u5  bash=4.3-11+deb8u2 \ 
     gnupg=1.4.18-7+deb8u5  tar=1.27.1-2+deb8u2 \ 
      #REMEDIATION 


FROM alpine:latest  
RUN apk --no-cache add ca-certificates
RUN apk add --update py-pip
RUN pip install django==1.2
RUN  pip install     "Django>=1.8.15"   #REMEDIATION 

WORKDIR /root/
COPY --from=0 /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"]  
