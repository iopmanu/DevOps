## Part 1. Установка ОС
![Установка системы](https://sun4-11.userapi.com/impg/kT9lOlbW7aNPJtodXakSHS1DkMMYQdKEBbGsCQ/l0D3xCiwUjg.jpg?size=1620x1308&quality=96&sign=13a60e63f4ad1ed83a1f4c653fb3830a&type=album)
* Чтобы узнать версию системы используем команду `cat /etc/issue`

## Part 2. Создание пользователя
![Создание нового пользователя](https://sun9-80.userapi.com/impg/gxSQ6Gg139huovVDRH0tYovEMljpwNPGuQ3vxw/iLRVs6T7frk.jpg?size=1616x490&quality=96&sign=1e0313ec50758ec7755d1d16ea5548b4&type=album)

* Чтобы создать пользователя используем команду `sudo useradd USER`
* Проверить, что новый пользователь был создан можно с помощью команды `cat /etc/issue`
![Вывод команды](https://sun9-76.userapi.com/impg/U8hNJUgzCbu-PtvKBtFwZEYBG1D0qLfBOUe_kg/Vm8b6vTOztg.jpg?size=1614x550&quality=96&sign=abc4c14fd61df5b406bd6356f4706c80&type=album)

## Part 3. Настройка сети ОС
* Для начала изменим имя машины на user-1 с помощью команды `sudo hostnamectl set-hostname USER`
![Результат выполнения](https://sun9-77.userapi.com/impg/wRiPf4ZkLB5Q_sowVgT85oOiXsBb9QfSg028aQ/s-Gke82LtXc.jpg?size=1614x396&quality=96&sign=03cd96a2fea78a9beb9bcb83956876e3&type=album). 
* Затем настроим часовой пояс с помощью команды `sudo timedatectl set-timezone TIMEZONE`
![Результат выполнения](https://sun9-38.userapi.com/impg/X9f-9C7upeIlrC0tS4Rz5XT8YTLgMxY5WYfsXw/m9yMDuiUDiE.jpg?size=1620x340&quality=96&sign=20d454a2e1f8b1e3a776c1e806daa4f4&type=album)
  
* Далее получим названия сетевых интерфейсов с помощью `ip -br link show`
![Вывод](https://sun9-87.userapi.com/impg/uTp_1NRTzrXpEJe-kPpRJT3DwaO30FqAtrbrTw/83GoTiBT_KY.jpg?size=1616x156&quality=96&sign=136828a99576abf79dd48a746c21f483&type=album)
* lo - **виртуальный интерфейс, присутствующий по умолчанию в любом Linux**. Он используется для отладки сетевых программ и запуска серверных приложений на локальной машине. С этим интерфейсом всегда связан адрес 127.0.0.1. У него есть dns-имя – localhost.
* Выведен и определен ip-adress устройства с помощью команды `ip a`, а также получен адресс от DHCP сервера с помощью команды `sudo dhclient -v enp0s3`
![Вывод ip](https://sun4-17.userapi.com/impg/EshNiOl8ogmoERN7gk0qumWYL8BeVwuR6k0z8Q/fmeqmFEwAfU.jpg?size=1616x1018&quality=96&sign=e1523768ead1806d36091c01dc0495d5&type=album)  
* DHCP — протокол прикладного уровня модели TCP/IP, служит для назначения IP-адреса клиенту. Это следует из его названия — Dynamic Host Configuration Protocol. IP-адрес можно назначать вручную каждому клиенту, то есть компьютеру в локальной сети. Но в больших сетях это очень трудозатратно, к тому же, чем больше локальная сеть, тем выше возрастает вероятность ошибки при настройке. Поэтому для автоматизации назначения IP был создан протокол DHCP.
* Далее были получены внешний и внутренний ip-адресса шлюза. 
* Внешний с помощью команды `wget -qO- eth0.me`
* Внутренний с помощью команды `ip route | grep default`
![Вывод команд](https://sun9-35.userapi.com/impg/7qHRcH_NNqPdUD76i2Llnqi_YfzkKEz9sxenrg/A4kpzZqKOuQ.jpg?size=1618x518&quality=96&sign=fc66d10e3458eb1ae7108c23ed3178fe&type=album)
* Далее чтобы задать статичные настройки ip, dns, gw открываем файл конфигурации network как `sudo vim /etc/netplan/00-installer-config.yaml`, отключаем dhcp, чтобы установить статичный ip.
![network config](https://sun9-33.userapi.com/impg/kCCxhVR0PgDo_TdQ7ochziCF7IEWB48oCmxyJA/2QTOsY9NNP4.jpg?size=1618x250&quality=96&sign=6a6d285ff193a81cbca294b49a8cddb1&type=album)
* Применяем команду `sudo netplan apply`, чтобы применить настройки без `reboot`.
![network settings](https://sun4-15.userapi.com/impg/hgLf2H6E17CFnWiMr_XwyX75IbCQOjtw5kixOw/TA8ZN49TJMA.jpg?size=1614x352&quality=96&sign=701e1557ed3800759e96f48e3eb289b7&type=album)

* Далее проверяем с помощью команды `ping IP/ -c address`
![pinging](https://sun9-17.userapi.com/impg/qpXhLkHZHDd0cCFFG8CedSEOJ6HjK3Zyg6CHQA/kt6Pp_n9PQI.jpg?size=1618x556&quality=96&sign=0f3d752712be154fc4b58dda8dc841c9&type=album)

## Part 4. OS Update
* Выполняем обновление с помощью команд `sudo apt-get update` и `sudo apt-get dist-upgrade`
* `dist-upgrade` делает тоже самое, что `upgrade` плюс выполяет «умное» разрешения конфликтов версий пакетов.
![Убеждаемся в установке](https://sun9-31.userapi.com/impg/muOMNv_w8vvjd6v60m_imGf1wv1_Q-kFPWkX9Q/i-QNGi7anpI.jpg?size=1622x566&quality=96&sign=6ff6b5f42f1c6c0bd4bc8f9f9e7dee6f&type=album)

## Part 5. Использование команды sudo
* Чтобы разрешить `sudo` для определенного круга пользователей нужно выполнить команду,  добавив в группировку с `sudo`: `usermod -a -G sudo <USER>`
* Чтобы сменить пользователя используем команду `su - <USER>`
* Чтобы сменить host выполняем `sudo -u <USER> hostnamectl set-hostname <HOSTNAME>`
![Результат смены имени хоста](https://sun9-6.userapi.com/impg/tK2gpoo8o6PmhDF7rPj2ULPKlEWZOkdU9_HuXQ/d96sahrJdEo.jpg?size=1620x756&quality=96&sign=d174859c98bf35f7f99ce46464ca9502&type=album)

## Part 6. Установка и настройка службы времени
* `timedatectl` выводит информацию о времени. Чтобы вывести информацию о текущем времени часового пояса используем в комбинации с `grep` таким образом: `timedatectl | grep "Local time"`.
* Чтобы синхронизировать время используем команду `sudo timedatectl set-ntp 1`
![Новые настройки](https://sun9-1.userapi.com/impg/-ApwrDOlKHjduVqx7TNBPwz3GDLQ-Ta1bMGmqw/fPdkSoko0WU.jpg?size=1600x312&quality=96&sign=b34f96db12b295ad1a1dcb44f00526aa&type=album)

## Part 7. Установка и использование текстовых редакторов
* Чтобы использовать текстовый редактор vim, воспользуемся `vim <FILE>`, аналогично `nano <FILE>` .
* Чтобы выйти из nano с сохранением изменений - CTRL + X -> yes.
* Чтобы выйти из vim c сохранением изменений - :wq
* Чтобы выйти из mcedit - ESC -> save
### Изменения с сохранением
![vim](https://sun9-3.userapi.com/impg/6MuaBDnAj6uvytu7qUIDUAmOxN67dRiKNeYD8Q/M2Ml9-5XuBo.jpg?size=1616x1206&quality=96&sign=1093967c7d7ac124feef519a0a211d14&type=album)
![nano](https://sun9-53.userapi.com/impg/AkxTF_7U6_yGhii2fNiKXkdJ0YBCtpBhYEaCjQ/RZ7Yha71kqA.jpg?size=1622x1054&quality=96&sign=c3fe18b7afe082ae41c4bfa84e9d44d4&type=album)
![mcedit](https://sun9-52.userapi.com/impg/W6egGNI5QWJ_3l0ZAobLuYorcfekDUWglywPrg/d7Ro0tZbgy4.jpg?size=1618x1218&quality=96&sign=b829ab68574b67c732ab245645d5ab9d&type=album)

### Изменения без сохранения
* Выполняя аналогичные команды откроем на редактирование уже имеющиеся файлы и заменим ник на 21 School 21.
* Для выхода без сохранения изменений в vim - q!
* Для выхода без сохранения изменений в nano -  CTRL + X -> no
* Для выхода без сохранения изменений в mcedit - ESC -> no

### Поиск в редакторе
![Поиск в vim](https://sun9-18.userapi.com/impg/jmZvtwW4t0FDMMvMyunrgtePxDbabwaBTdWMXg/isd9z-_nvfk.jpg?size=1618x1214&quality=96&sign=f4116177bf85d2b55da96ecedf0d5534&type=album)
![Поиск в nano](https://sun9-65.userapi.com/impg/SJLKgVdIrPU8TXp5qMBfSzvVxwZBYwRnfz1s9A/emPZLkww-rw.jpg?size=1616x1208&quality=96&sign=c5680f189ad86d4262790f2cbbcb1a4f&type=album)
![Поиск в mcedit](https://sun9-71.userapi.com/impg/DBKVHwSafvKj2miraZZa4-L1fhPX-0dp0tMBJQ/Fru6Cb0kcKY.jpg?size=1624x1212&quality=96&sign=47fc816e0eaefc87ce07a2984a3e548c&type=album)

### Замена в редакторе
* Для замены в vim нужно воспользоваться :s/word/replace
* Для замены в nano нужно воспользоваться CTRL + \ -> search -> replace
* Для замены в MCEDIT нужно воспользоваться CTRL + 4

![Замена в VIM](https://sun9-72.userapi.com/impg/F4k8Ro7YuppMdS6vgt690J6QU4Aa63EknqOlaA/YUy_eFnu1Ic.jpg?size=1618x1222&quality=96&sign=c574b71984e20862a95bfd82b8cae504&type=album)
![Замена в nano](https://sun4-10.userapi.com/impg/6rj1OVfb2PETxrSLRwZU0gErsOlFU350a1EZVg/yvA-cFY_LQ0.jpg?size=1618x1136&quality=96&sign=ca9d4acc4637327d09bd489e883186bf&type=album)
![Замена в MCEDIT](https://sun9-41.userapi.com/impg/K_QqX0X_a6DKVEsFdjtsGxBr051in1AI0ePvZA/rSZJ-jvrHwE.jpg?size=1618x1206&quality=96&sign=485545dc15d0c15bd5da4e9a95aba3ce&type=album)

## Part 8. Установка и базовая настройка сервиса **SSHD**
### Работа с SSH
* Для установки `sudo apt-get install ssh`->`sudo apt install openssh-server`
* Чтобы добавить в автозагрузку `sudo systemctl enable sshd`
* Проверить работу с помощью `systemctl status sshd`
* Открыть конфигурационный файл `sudo vim /etc/ssh/sshd_config`и изменить порт

![Изменение порта](https://sun9-86.userapi.com/impg/MsCwBggdSfzFaOOW0kd5wJyqI7asJ3KCMfCFLg/D7eFp7-eyCY.jpg?size=1618x1104&quality=96&sign=a026140b995a4c9b4d6d16806b6e051d&type=album)
![Скриншот status sshd](https://sun9-69.userapi.com/impg/iU9hU8qm5FaMEm83Le5POADqeSNK1PLc0qYyBQ/NNrHmmJqhiY.jpg?size=1618x656&quality=96&sign=259165e5a8b15e02ad8d7aefd9644a53&type=album)

### Работа с ps
* Нужная комбинация: `ps -F -a`
* `ps -a` для просмотра всех запущенных процессов.
* `ps -F` - Extra Full Format.

### Работа с netstat
* Далее по заданию требуется установить netstat, команда - `sudo apt install net-tools`
* Вызов команды с нужными опциями: `nestat -tan`
* Флаг **-t** - вывод TCP соединений
* Флаг **-a** - вывод всех портов
* Флаг **-n** - вывод адресов в числовом виде Значения столбцов:
* **Proto**: название протокола
* **Recv-Q**: очередь приема. Это входящие байты, которые были получены и помещены в буфер, ожидая, пока локальный процесс, использующий это соединение, прочитает и использует их.
* **cSend-Q**: очередь отправки. Показывает байты, которые готовы к отправке из очереди отправки.
* **Local Address**: локальный IP-адрес участвующий в соединении или связанный со службой, ожидающей входящие соединения (слушающей порт). Если в качестве адреса отображается 0.0.0.0, то это означает - "любой адрес", т.е в соединении могут использоваться все IP-адреса существующие на данном компьютере. Адрес 127.0.0.1 - это петлевой интерфейс, используемый в качестве средства IP протокола для взаимодействия между процессами без реальной передачи данных.
* **Foreign Address**: адрес и номер порта удаленного конца соединения.
* **State**: состояние соединения. Состояние  _Listening_  говорит о том, что строка состояния отображает информацию о сетевой службе, ожидающей входящие соединения по соответствующему протоколу на адрес и порт, отображаемые в колонке "Локальный адрес ". Состояние  _Established_  дает понять, что между сервером и клиентом установлено рабочее соединение, позволяющее передавать данные между ними.
![Вывод команды netstat](https://sun9-85.userapi.com/impg/jcW5B7Otb1K0kXEuCorHz4DfPtKXL5fWa5IEoQ/r6J_Hm2zUKY.jpg?size=1618x398&quality=96&sign=20a1891ac2a84f4de14d3b0d2ca12156&type=album)

## Part 9. Установка и использование утилит **top**, **htop**
### 1. Пользуемся утилитой top
* Для установки утилит `sudo apt update` -> `sudo apt-get install htop`
![Вывод top](https://sun9-27.userapi.com/impg/e7tBv5Hkz0VN4MTHQ2zbxeOqf2MpsZ3GN3wfqg/H3vUX1dB0h0.jpg?size=1616x1016&quality=96&sign=060ef4de570eecb503f5edef969845f9&type=album)
* **Uptime** - 15:11
* **Количество пользователей**  - 1 user
*  **Загрузка системы** - 0.00, 0.03, 0.02
*  **Загрузка cpu** 
	 - 0.0 us (User CPU time) процент использования процессорного времени программами пользователей;
	 - 0.0 sy (System CPU time) процент использования процессорного времени процессами ядра Linux;
	 - 0.0 -   ni — (Nice CPU time) процент использования процессорного времени программами с измененным приоритетом;
	 - 100.0 id — простой процессора;
	 -  0.0 wa (iowait) время, затраченное на завершение ввода/вывода (IO);
	 - 0.0 hi (Hardware IRQ) процент времени, которое процессор тратит на обработку прерываний на уровне;
	 - 0.0 si (Software Interrupts) процент времени, затраченное на работу обработку software-прерываний (network);
	 - 0.0 st (Steal Time, Время кражи) время, «украденное» гипервизором у этой виртуальной машины для других задач 						(например работа другой виртуальной машины).
*  **Количество процессов** - 96, из которых 1 запущенный.
*  **Загрузка памяти** - 976.9 всего, 215.4 свободно, 147.3 используется.
*  **PID процесса занимающего больше всего памяти** - 1
*  **PID процесса, занимающего больше всего процессорного времени** - 1
### 2. Пользуемся утилитой htop
* Сортировка по PID
![Отсортированные по PID](https://sun9-61.userapi.com/impg/3Ly37BZggsJoPrkn1HaaZW2W-CQWbLzlFtf5xg/byl428CgjCQ.jpg?size=1620x1216&quality=96&sign=f8ed54a0d4aa56dc5a4a487bf11f9475&type=album)
* Фильтрация для процесса sshd
![Фильтрация для процесса sshd](https://sun9-38.userapi.com/impg/hKWl0DjkwYDw2z_jmdFtYTBVYZ3QdibwulhRaw/q9QvC87X9os.jpg?size=1622x1214&quality=96&sign=c3732b6d9799905cea787ce1c78b4c36&type=album)
* C процессом syslog, найденным, используя поиск
![C процессом syslog, найденным, используя поиск](https://sun9-33.userapi.com/impg/opAFmVmhw81rnPTr1wXZ3172ryXDhwFmC5bdXA/FxDwHsVAbVc.jpg?size=1622x1212&quality=96&sign=e616c954ccf67871fe4e8fa33a29efc2&type=album)
* C добавленным выводом hostname, clock и uptime
![C доп. параметрами](https://sun9-64.userapi.com/impg/qImj2zEMIz2oBYfi8K9lQXLC2A9qMEHDF5J8jA/asjq_q-j0uA.jpg?size=1622x668&quality=96&sign=104e7c5611fc57fa36d436b876458efc&type=album)

## Part 10. Использование утилиты **fdisk**
* Запуск с помощью `sudo fdisk -l`
![fdisk](https://sun9-37.userapi.com/impg/rO7AvlkYMURNMhY4IsAWE7VEdys9f_cYLXwm1Q/uYCCHdEnRuc.jpg?size=1618x1092&quality=96&sign=68ecd0280119c7f5bc035f6a54d44f7d&type=album)
* Название жесткого диска - **/dev/sda**
* Размер жесткого диска -  **10 GiB, 10737418240 bytes**
* Количество секторов - **20971520**
* Размер swap `swapon --show`
![swap размер](https://sun9-17.userapi.com/impg/cyUqJ3EKwPWluNGwBLyp2r31F7OxQWlTER4Xog/wQ2QkltO-zI.jpg?size=886x188&quality=96&sign=f2d288e1afb172042ac3297fa080a6b1&type=album)

## Part 11. Использование утилиты **df**
### 1. Запуск df
![Вывод](https://sun4-12.userapi.com/impg/x7RyYV_fekmDFcWt3QCo0tAsnuBaREgZ4v3ppQ/voFqFoo8N7Y.jpg?size=1618x530&quality=96&sign=e0db9114b5ef57aa39d056a7c112bdb4&type=album)
* Размер раздела - **8408452 bytes**
* Размер занятого пространства - **4241680 bytes**
* Размер свободного пространства - **3718056 bytes**
* Процент использования - **54%**
### 2. Запуск df - Th
![Вывод](https://sun9-83.userapi.com/impg/o1ogVPVIaDGVFPNxsbhYug_yFZtrcUfPU0c-7A/cYixyO6_7hs.jpg?size=1618x486&quality=96&sign=ca8a41998a93ee858441c6ae6648a001&type=album)
* Размер раздела - **8.1 G**
* Размер занятого пространства - **4.1 G**
* Размер свободного пространства - **3.6 G**
* Процент использования - **54%**
* Тип файловой системы - **ext4**; Журналируемая файловая система.

## Part 12. Использование утилиты **du**
* Запуск утилиты с помощью команды `du`
* Для вывода последовательности директорий используем опцию `-s`
* Для вывода в киллобайтах/мегабайтах используем опцию `-h`
* Далее вывод для папок /home, /var
![Вывод](https://sun9-41.userapi.com/impg/EqG-Nhh2kCbyiQ7QQljvLR2v7uPrFE_1ESwcmg/qaqHC0qGrIg.jpg?size=1618x156&quality=96&sign=d257277c12d464eda8f8484c743b1181&type=album)

* Вывод для /var/log
![Вывод](https://sun9-83.userapi.com/impg/S_sqT3xZF-R9RAMsO9jyJfJw1wUdSeV2hO-TUg/coS68htZOvA.jpg?size=1624x156&quality=96&sign=9d99b5d401fa6aff6859b9ae3d3078c2&type=album)
* Вывод размера всего содержимого для /var/log используя *
![Вывод](https://sun9-83.userapi.com/impg/_2kpzB-om8L_ob1OPFtq2hkhNweqhq8ny0Se8A/MIy3vEwSUMY.jpg?size=1620x946&quality=96&sign=77680001d19ff8874b0303a419b91bd0&type=album)

## Part 13. Установка и использование утилиты **ncdu**
* Установка с помощью команды `sudo apt-get install ncdu`
![Установка](https://sun9-61.userapi.com/impg/A0tL6yapO44snY0Oa_upECGWngW6krPyyFJOpg/6heyF0JL-LQ.jpg?size=1622x562&quality=96&sign=8b435012fba04c0c3c6e3752f8ebe14f&type=album)
* Вывод для **/home**
![/home](https://sun4-17.userapi.com/impg/apwlqAplknXwVSLWqCdli4ki7kZzvc4Mf_8jsg/C7pJq-Fvoz4.jpg?size=1622x366&quality=96&sign=6b9e06b18ae786e1f1491c50d947ce48&type=album)
* Вывод для **/var**
![/var](https://sun9-66.userapi.com/impg/eShZnkIIxR_MRXJ61NlE9ZR-ATE-tWazDZDxSg/hhYYMYm_njs.jpg?size=1624x576&quality=96&sign=d66e587d18f1bc13ab77d2ed85c3ccbd&type=album)
* Вывод для **/var/logs**
![/var/logs](https://sun9-22.userapi.com/impg/FZicSJH8PQRUg02iqoVbgFhm6Qm-twACMb5Z_w/ZmTq0jRyeTw.jpg?size=1618x914&quality=96&sign=4ef4e096c8697823528563df701fb604&type=album)
* Сумма содержимого этих папок примерно совпадает с результатами полученными с помощью `du`
## Part 14. Работа с системными журналами
* Последняя успешная авторизация, имя пользователя и метод входа в систему.
![Последняя аутентификация](https://sun9-29.userapi.com/impg/nb1FeJmyU_cG7UsCqelEe6J9rzWsQMe0YA4J9w/DCF38fzFaNk.jpg?size=1622x70&quality=96&sign=b090026f4ee97c10ba35bc79ea5bf1d7&type=album)
* Restart службы sshd с помощью команды `systemctl restart sshd`
![Логи](https://sun9-58.userapi.com/impg/ZpjEEn6GGlsMYWvPFVkHes6cyIBjM-fcZ9n7wA/Llc3X_8j-IU.jpg?size=1626x112&quality=96&sign=d65831c12164c02d724ea9b5035549d7&type=album)

## Part 15. Использование планировщика заданий **CRON**
* Открываем планировщик задач с помощью `crontab -e`
* Просмотр текущих задач с помощью `crontab -l`
![Просмотр текущих задач](https://sun9-81.userapi.com/impg/TIKPaiWkHfz0TqeKsqOY9QUap6tys-OAP50QNw/Gd0usEr2UDE.jpg?size=1620x818&quality=96&sign=295c1e40c47eaab235cbe0fe05ca1ec0&type=album)
* Просмотр выполненных задач с помощью `cat /var/log/syslog`
![Выполненные](https://sun9-51.userapi.com/impg/C0T4Pj-EdXYYMIuoZKBk-2eNCKm7RO2Vm86Mxw/Gk9xL5e7mjo.jpg?size=1624x74&quality=96&sign=cba8b21bf33b1e77c14ccfa7868546ae&type=album)
* Удаление аналогично с помощью `crontab -e`