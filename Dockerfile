# Stage 1: Build the app
FROM node:18-alpine as build

WORKDIR /app

# Copy the package files first (utilizing layer caching)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy all of the application files
COPY . .

# Build the application
RUN npm run build

# Stage 2: Run the app
FROM node:18-alpine

WORKDIR /app

# Copy the built files from the build stage
COPY --from=build /app .

# Expose port the app runs on
EXPOSE 3000

# Command to start the application
CMD ["npm", "start"]
