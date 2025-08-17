FROM node:24.6.0-bookworm-slim

# Install wget for downloading PocketBase
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Set PocketBase version
ENV PB_VERSION=0.29.2

# Set working directory
WORKDIR /app

RUN apt update && apt install -y \
    unzip git \
    && rm -rf /var/lib/apt/lists/*

# Download PocketBase binary (linux amd64)
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip && \
    unzip pocketbase_${PB_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm pocketbase_${PB_VERSION}_linux_amd64.zip

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Expose default SvelteKit and PocketBase ports
EXPOSE 5173 8090

# Entrypoint example (customize as needed)
# CMD ["npm", "run", "dev"]
