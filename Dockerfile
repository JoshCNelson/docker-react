# build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase
# by putting in a second FROM statement Docker understands
# you are executing a second step of the build
# you can only have one FROM per phase
FROM nginx
# I want to copy over something from the specified phase (builder in this case)
COPY --from=builder /app/build /usr/share/nginx/html
# nginx starts up automatically, just need to have the files here

