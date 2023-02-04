## Part 1. Готовый докер
* Взять официальный докер образ с nginx и выкачать его при помощи **docker pull**
* Проверить наличие докер образа через **docker images**
* Запустить докер образ через **docker run -d [image_id|repository]**
* Проверить, что образ запустился через **docker ps**
* Посмотреть информацию о контейнере через docker **inspect [container_id|container_name]**
![screen](https://sun9-46.userapi.com/impg/cWYcvGKGSr6v4u-XqyFRNwC1BqGKuotK43xAEA/O022ZDdCbQo.jpg?size=1156x604&quality=96&sign=67fc8b1071783c65f16a34f8d52be55b&type=album)

* По выводу команды определить и поместить в отчёт размер контейнера, список замапленных портов и ip контейнера
![screen](https://sun9-19.userapi.com/impg/womciHmMSNOpxCTGEQzv4OwChqmIplZxgpa3UA/knRByWQOUTU.jpg?size=1072x124&quality=96&sign=3e9261ea7120571676a9b3b9572350d8&type=album)
![screen](https://sun9-50.userapi.com/impg/8jE9rr3bduWf_JFaXJKFMthBxpN_-I0IgxQjvQ/4hLMKi3EXRQ.jpg?size=1089x63&quality=96&sign=4752a5ce4d50b8e90398fdf4dcf7b715&type=album)
* Остановить докер образ через **docker stop [container_id|container_name]**
* Проверить, что образ остановился через **docker ps**
![screen](https://sun9-40.userapi.com/impg/FxqMHVTnNJaU8ciE9ej-YqIDKa0Wn4BiQ0pzSQ/aKos-phFgSY.jpg?size=1089x197&quality=96&sign=bd6223a8cce4bdba6344deeb872707f3&type=album)
* Запустить докер с замапленными портами 80 и 443 на локальную машину через команду run
* При запуске нового Docker-контейнера с помощью команды **docker run** можно сопоставить порты опцией **—publish или -p:**
* Проверить, что в браузере по адресу localhost:80 доступна стартовая страница nginx
![screen](https://sun9-84.userapi.com/impg/S9aMH5T4U54NZrr16kbvdJpsk47Z-wRaSPtqpg/eefPI-udRgA.jpg?size=1061x377&quality=96&sign=54f805189886b62260937a8515d154de&type=album)
* Перезапустить докер контейнер через **docker restart [container_id|container_name]**
![screen](https://sun9-50.userapi.com/impg/qoomPTqdMaQyko-oZwNVklxG-oNxV7udfgS77A/txa6M_PCT58.jpg?size=1046x633&quality=96&sign=0df9e9614404aae61c7fbce5a7d3589c&type=album)

## Part 2. Операции с контейнером
* Прочитать конфигурационный файл nginx.conf внутри докер контейнера через команду exec
![screen](https://sun9-43.userapi.com/impg/yxmCxBjLYPQZkf9LX4lrKP0icPUd-j4rTKcoPQ/iaocw42xhq8.jpg?size=1048x628&quality=96&sign=82890a79dfbdb9941773e29811c0bd25&type=album)
* Настроить в нем по пути /status отдачу страницы статуса сервера nginx
![screen](https://sun9-51.userapi.com/impg/XRKLag8YboZB5IcEieT8T7P_lwP38PLBexZDfw/dCY7l2m-U4E.jpg?size=1045x540&quality=96&sign=d70a3c9ae50fc66e9abb6a4eb33efe61&type=album)
* Перезапустить nginx внутри докер образа через команду exec
* Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx
![screen](https://sun9-84.userapi.com/impg/Ddo3lqGwDHE2cFc_UYnFghcMueHhnX8bfDTXMw/O3o3UOUmmpU.jpg?size=994x296&quality=96&sign=e5999f479124bdfc4b143fae71642311&type=album)
* Экспортировать контейнер в файл container.tar через команду export
* Остановить контейнер
* Удалить образ через **docker rmi [image_id|repository]**, не удаляя перед этим контейнеры
![screen](https://sun9-84.userapi.com/impg/cnavd8cwNCW0_sKhUBAtjFbSY_49fXt3tx1fWQ/vUEtmUji8bY.jpg?size=1066x223&quality=96&sign=d8850ace5e6f5473208ffa713857cc50&type=album)
* Удалить остановленный контейнер
![screen](https://sun9-40.userapi.com/impg/PUSBGA4Jms2ux-x5ManJPm11f_U1dvUh0jAEzA/MHUOPzdioYo.jpg?size=1066x223&quality=96&sign=825785d6e41df608134cdfc05365216e&type=album)
* Импортировать контейнер обратно через команду import
* Запустить импортированный контейнер
![screen](https://sun9-63.userapi.com/impg/4nrHcEPIag7yi5dwS_SaBxTUq-1meNCtGmczDA/E0dPllJskpE.jpg?size=1402x573&quality=96&sign=b163eb97d355204af07af9220f31a42c&type=album)

## Part 3. Мини веб-сервер
* Написать мини сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello World!
* Запустить написанный мини сервер через spawn-fcgi на порту 8080
* Написать свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080
* Проверить, что в браузере по localhost:81 отдается написанная вами страничка
* Положить файл nginx.conf по пути ./nginx/nginx.conf (это понадобится позже)
![screen](https://sun9-80.userapi.com/impg/3-xfK_EagKsxPqNM7Q4Bf0WySgiKkKqHGmYxMA/uZP9k-Kz80s.jpg?size=1285x379&quality=96&sign=ce6cb78b41f9ba0a976793ba9b1c92e4&type=album)

## Part 4. Свой докер
* Cобирает исходники мини сервера на FastCgi из Части 3
* Запускает его на 8080 порту
* Копирует внутрь образа написанный ./nginx/nginx.conf
* Запускает nginx
* Собрать написанный докер образ через **docker build** при этом указав имя и тег
* Проверить через **docker images**, что все собралось корректно
* Запустить собранный докер образ с маппингом 81 порта на 80 на локальной машине и маппингом папки ./nginx внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а (см. Часть 2)
* Проверить, что по localhost:80 доступна страничка написанного мини сервера
* Дописать в ./nginx/nginx.conf проксирование странички /status, по которой надо отдавать статус сервера nginx
* Перезапустить докер образ
![screen](https://sun9-83.userapi.com/impg/I_l38hetuW1GS-FLcyKYJPn_R5mqgCNDD8Udnw/1oXvdS7oXfY.jpg?size=1292x624&quality=96&sign=09ddca52f7912b5758080794f14c501d&type=album)

## Part 5. Dockle
* Просканировать образ из предыдущего задания через dockle [image_id|repository]
* Исправить образ так, чтобы при проверке через dockle не было ошибок и предупреждений
![screen](https://sun4-17.userapi.com/impg/0orjh03kg5oiZaVjupsZ3sXeghCydgze3PeuyQ/b7b4FiCjprs.jpg?size=1292x624&quality=96&sign=9e941cd426dbaa27ee640f5aae76b838&type=album)

## Part 6. Базовый Docker Compose
* Поднять докер контейнер из Части 5 (он должен работать в локальной сети, т.е. не нужно использовать инструкцию EXPOSE и мапить порты на локальную машину)
* Поднять докер контейнер с nginx, который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера
* Замапить 8080 порт второго контейнера на 80 порт локальной машины
* Остановить все запущенные контейнеры
* Собрать и запустить проект с помощью команд **docker-compose build** и **docker-compose up**
* Проверить, что в браузере по localhost:80 отдается написанная вами страничка, как и ранее
![screen](https://sun9-59.userapi.com/impg/5IdCqps7RcrZRtanryrPo3g6fxG7LWw34Ipfmg/bvMS0oW24Us.jpg?size=1292x673&quality=96&sign=7e618fdb4d7205eb810d1c72abb5763b&type=album)

