# Build stage for Spring Boot
FROM maven:3.8.5-openjdk-17 AS backend-build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Build stage for Vue.js
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
# Install required dependencies
RUN npm install --save-dev @babel/core @babel/eslint-parser @babel/preset-env \
    @vue/cli-plugin-babel @vue/cli-plugin-eslint @vue/cli-service \
    @vue/compiler-sfc vue-template-compiler
# Create a temporary .eslintrc.js
RUN echo "module.exports = { root: true, env: { node: true }, extends: ['plugin:vue/vue3-essential'], parserOptions: { parser: '@babel/eslint-parser' }, rules: { 'vue/multi-word-component-names': 'off' } }" > .eslintrc.js
# Create a temporary babel.config.js
RUN echo "module.exports = { presets: ['@vue/cli-plugin-babel/preset'] }" > babel.config.js
# Build the application
ENV NODE_ENV=production
RUN npm run build

# Final stage
FROM openjdk:17-jdk-slim
WORKDIR /app
# Copy backend jar
COPY --from=backend-build /app/target/*.jar app.jar
# Copy frontend dist
COPY --from=frontend-build /app/frontend/dist /app/static

# Environment variables
ENV SPRING_PROFILES_ACTIVE=prod

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]