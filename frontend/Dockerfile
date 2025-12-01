# build stage
FROM node:20-alpine as build-stage
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --silent || npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
# Add a custom nginx config to proxy API calls to backend service
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
