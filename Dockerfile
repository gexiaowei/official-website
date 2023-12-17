# build stage
FROM node:18.19-alpine as build-stage
WORKDIR /app
COPY package.json ./
RUN yarn
COPY . .
RUN yarn build

# production stage
FROM nginx:stable as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]