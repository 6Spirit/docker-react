FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# /app/build <-- this folder will contain all the stuff we care about (npm build files)

FROM nginx
# where we copy the files to is actually specified in the nginx documentation
COPY --from=builder /app/build /usr/share/nginx/html