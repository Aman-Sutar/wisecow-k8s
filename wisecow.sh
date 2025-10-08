# Use the official minimal Alpine Linux image
FROM alpine:latest

# Install dependencies for the app (bash, nc, fortune, cowsay, node.js, and npm)
RUN apk update && apk add --no-cache \
    bash \
    ncurses \
    fortune \
    netcat-openbsd \
    nodejs \
    npm \
    dos2unix  # Add dos2unix utility for handling Windows line endings

# Install cowsay via npm
RUN npm install -g cowsay

# Set the working directory to /app
WORKDIR /app

# Copy the Wisecow script to the container
COPY wisecow.sh /app/

# Ensure the script has Unix-style line endings (if necessary)
RUN dos2unix wisecow.sh

# Make the script executable
RUN chmod +x wisecow.sh

# Expose the port the application will run on
EXPOSE 4499

# Command to run the script when the container starts
CMD ["bash", "./wisecow.sh"]
