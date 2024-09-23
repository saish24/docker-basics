# Use the official Go image as a base
FROM golang:1.22 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules files and install dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o docker-basics .

# Use a minimal base image to run the compiled binary
FROM alpine:latest  

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/docker-basics .

# Command to run the executable
CMD ["./docker-basics"]
