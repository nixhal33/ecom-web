# ============================================================
# Stage 1: Build the React app
# ============================================================
FROM node:16-alpine AS builder    # ✅ downgrade from 20 to 16 as it was from older version based project.
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

RUN rm -rf ./*

COPY --from=builder /app/build .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]