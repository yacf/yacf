![alt text](https://raw.githubusercontent.com/yacf/docs/master/_assets/images/logo-p.png "YACF")

## Yet Another CTF Framework

Welcome to the home of YACF code repository. Please visit the docs at www.yacf.io!

```
$: docker build -t yacf .
$: docker run -d -p80:80 -p443:443 -h <HOSTNAME> --volume /home/ubuntu/ssl:/etc/apache2/ssl/ --restart=always yacf
```

```
docker run -d -p80:80 -p443:443 -h <HOSTNAME> --volume /home/ubuntu/ssl:/etc/apache2/ssl/ --volume /home/ubuntu/db/db.sqlite3:/var/www/backend/db.sqlite3 --restart=always yacf
```

```
certbot -d *.*.com --manual --preferred-challenges dns certonly
```

```
docker exec -i -t <NAME> /bin/bash
```

```
docker run -d -p5432:5432 -e POSTGRES_USER=django -e POSTGRES_PASSWORD=plzchange -e POSTGRES_DB=postgres -v $(pwd)/postgres/data:/var/lib/postgresql/data/ postgres:latest

docker run -d -p5432:5432 -e POSTGRES_USER=django -e POSTGRES_PASSWORD=plzchange -e POSTGRES_DB=postgres postgres:latest
```

```
docker exec <postgres_container_name> pg_dump -U <username> <database_name> > <file.sql>

docker exec db psql -U <username> -d <database_name> -f <file.sql>
psql -d postgres -U django -f file.sql

```

```
import random
import string

password_characters = string.ascii_letters + string.digits + string.punctuation
''.join(random.choice(password_characters) for i in range(50))
```

Security Checklist
```
Change DNS in confs
Change key for django
Change django Debug to off
Change DB password
Disable GraphiQL
CORS Disable
```

cd /var/www/backend/; python3 prod_db.py