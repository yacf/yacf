FROM node:lts-alpine as builder
WORKDIR '/app'
COPY . .
RUN yarn install
RUN yarn build

FROM nginx:latest
# COPY ./scripts/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist/ /usr/share/nginx/html

# docker run -d -v /Volumes/HOME/Code/yacf/frontend/src/scripts/nginx.conf:/etc/nginx/conf.d/default.conf -p8081:80 frontend

# docker run -d -v /Volumes/HOME/Code/yacf/frontend/src/scripts/nginx.conf:/etc/nginx/conf.d/default.conf --name frontend frontend