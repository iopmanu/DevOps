docker pull nginx
docker run -d -p 81:81 --name web_server nginx
docker cp ./server.c web_server:etc/nginx/
docker cp ./nginx.conf web_server:/etc/nginx/
docker exec web_server apt-get update
docker exec web_server apt-get install -y gcc spawn-fcgi libfcgi-dev
docker exec web_server gcc /etc/nginx/server.c -o /etc/nginx/webserver -l fcgi
docker exec web_server spawn-fcgi -p 8080 /etc/nginx/webserver
docker exec web_server nginx -s reload
