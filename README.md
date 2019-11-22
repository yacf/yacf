![alt text](https://raw.githubusercontent.com/yacf/docs/master/_assets/images/logo-p.png "YACF")

## Yet Another CTF Framework

Welcome to the home of YACF code repository. Please visit the docs at www.yacf.io!

```
$: docker build -t yacf .
$: docker run -d -p80:80 -p443:443 -h play.nullify.uno --volume /home/ubuntu/ssl:/etc/apache2/ssl/ --restart=always yacf
```

```
docker run -d -p80:80 -p443:443 -h play.nullify.uno --volume /home/ubuntu/ssl:/etc/apache2/ssl/ --volume /home/ubuntu/db/db.sqlite3:/var/www/backend/db.sqlite3 --restart=always yacf
```

```
certbot -d *.*.com --manual --preferred-challenges dns certonly
```
