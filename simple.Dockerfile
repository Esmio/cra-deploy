FROM node:14-alpine as builder

WORKDIR /code

ADD package.json yarn.lock /code/
RUN yarn

ADD . /code
RUN yarn build

FROM nginx:alpine
ADD nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /code/build /usr/share/nginx/html