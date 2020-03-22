# Base Image LAMP

- L: Linux alpine
- A: Apache
- M: MySQL
- P: PHP 7.3
- PHP MySQL Ext
    + mysql
    + mysqli

## Usage

### Files

- src 网站源码
    + index.php
    + ...etc
- Dockerfile
- docker-compose.yml

### Dockerfile

```bash
FROM docimg/baseimg_mysql_php73_apache
```

### Deploy

```bash
docker build -t docimg/baseimg_mysql_php73_apache .
docker push docimg/baseimg_mysql_php73_apache

docker stop baseimg_mysql_php73_apache
docker rm baseimg_mysql_php73_apache
docker run -d --name baseimg_mysql_php73_apache -p 8081:80 docimg/baseimg_mysql_php73_apache
docker exec -it baseimg_mysql_php73_apache /bin/bash
```
默认用户：www-data