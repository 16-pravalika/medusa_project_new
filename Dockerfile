FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install OS dependencies
RUN apk add --no-cache bash

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Set environment variables for production-friendly Medusa + AWS RDS self-signed cert handling
ENV NODE_ENV=production
ENV NODE_TLS_REJECT_UNAUTHORIZED=0

# Expose Medusa default port
EXPOSE 9000

# Start Medusa server
CMD ["npm", "run", "start"]