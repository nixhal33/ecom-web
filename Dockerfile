# ============================================================
# Stage 1: Build the React app
# ============================================================
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package files first (layer caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --silent

# Copy source code
COPY . .

# Build for production
RUN npm run build

# ============================================================
# Stage 2: Serve with Nginx
# ============================================================
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Remove default nginx static files
RUN rm -rf ./*

# Copy built React app from Stage 1
COPY --from=builder /app/build .

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
