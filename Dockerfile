# Pull base goland & Build 
FROM golang:1.17-alpine as go-deploy-env
 
# Set environment variable
ENV APP_NAME schedServerApp
ENV CMD_PATH main.go
 
# Copy all data into image
COPY . $GOPATH/src/$APP_NAME
WORKDIR $GOPATH/src/$APP_NAME
 
# Build 
RUN CGO_ENABLED=0 go build -v -o /$APP_NAME $GOPATH/src/$APP_NAME/$CMD_PATH
 
# Run Stage
FROM alpine:3.18

# Expose  port
EXPOSE 2345
 
# Copy only required data into this image
COPY --from=go-deploy-env /schedServerApp .
 
# Start app
CMD ./$APP_NAME