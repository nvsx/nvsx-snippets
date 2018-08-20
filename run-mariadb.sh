# https://hub.docker.com/_/mariadb/

#docker run --rm -it --name=mariadb -v $(pwd)/data:/var/lib/mysql -e "MYSQL_ROOT_PASSWORD=admin" mariadb:latest

#docker run -d --name mariadb \
docker run --rm --name mariadb \
    -v $(pwd)/data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=admin \
    -e MYSQL_USER=admin \
    -e MYSQL_PASSWORD=admin \
    -e MYSQL_DATABASE=db1 \
    mariadb:latest \
    --character-set-server=utf8 \
    --collation-server=utf8_unicode_ci
    
    
