# Mission Control (Vite) container
# Note: This builds the frontend at container startup so VITE_CONVEX_URL can be
# provided via Kubernetes env (ConfigMap/Secret) without rebuilding the image.

FROM node:20-alpine

WORKDIR /app

# Install deps first for layer caching
COPY package.json package-lock.json ./
RUN npm ci

# App source
COPY . .

EXPOSE 4173

# Build at startup so VITE_CONVEX_URL is available.
# (Vite only inlines VITE_* env vars at build time.)
CMD ["sh", "-c", "npm run build && npm run preview -- --host 0.0.0.0 --port ${PORT:-4173}"]
