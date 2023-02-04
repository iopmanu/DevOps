docker build -t server:new .
docker run -d -p 80:81 --name web_server server:new
