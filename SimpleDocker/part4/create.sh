docker build -t server .
docker run -d -p 80:81 --name web_server server
docker exec web_server bash run.sh
