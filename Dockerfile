# Use a smaller base image for better performance and smaller image size
FROM node:alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only package.json and package-lock.json (if available) first to leverage Docker layer caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy application files after dependencies
COPY graphserver.js UScities.json ./

# Expose the application port
EXPOSE 4000

# Set the default command to run the server
CMD ["node", "graphserver.js"]
