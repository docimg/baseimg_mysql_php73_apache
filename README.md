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

```
FROM docimg/baseimg_mysql_php73_apache
```
