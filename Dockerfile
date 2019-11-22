FROM node:lts-alpine as builder
WORKDIR '/app'
COPY ./frontend .
RUN yarn install
RUN yarn build
RUN mv dist/static/js dist/js
RUN rm -rf dist/static/
RUN cat dist/index.html | sed 's/\/css\//\/static\/css\//g' > dist/temp.html
RUN mv dist/temp.html dist/index.html


FROM ubuntu:18.04

LABEL maintainer="Mickey Hefley <0xCODEs>" 

RUN apt-get update     && \
    apt-get upgrade -y && \
    apt-get install -y    \
    python3      \
    python3-pip  \
    libpq-dev    \
    apache2      \
    tmux         \
    nano         \
    openssl      \
    libsasl2-dev \
    python-dev   \
    libldap2-dev \
    libssl-dev   \
    libapache2-mod-wsgi-py3

RUN apt-get clean

COPY scripts/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

COPY backend/ /var/www/backend/
COPY --from=builder /app/dist/ /var/www/backend/static/

RUN chmod 664 /var/www/backend/db.sqlite3
RUN chown -R www-data:www-data /var/www/

COPY scripts/apache/development.conf /etc/apache2/sites-available/000-default.conf

CMD apachectl -D FOREGROUND