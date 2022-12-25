## Part 1. Инструмент **ipcalc**
* Для установки вводим `sudo apt-get ipcalc`
### 1.1.1
* Адрес сети _192.167.38.54/13_ - _192.160.0.0/13_
### 1.1.2
* Перевод маски _255.255.255.0_  в префиксную и в двоичную, нас интересует поле **Netmask**:
![Перевод](https://sun4-15.userapi.com/impg/eyWTzDEi82dHLXlgQ3CLzD8WcV0tRj4GQf933Q/lUWsMdt4Afs.jpg?size=1618x136&quality=96&sign=df196fe6b82d922d900d528b8ed67878&type=album)
* Перевод маски _/15_ в префиксную и в двоичную:
![Перевод](https://sun4-16.userapi.com/impg/zUtXucpXS1DXrMNCVWnOyzsUSeiWXI5IHVqlvw/smIAZBa5JkY.jpg?size=1622x130&quality=96&sign=2a4fc04a4d74d4baf49a695aeaa767ea&type=album)
* Перевод маски _11111111.11111111.11111111.11110000_ в префиксную и в двоичную:
![Перевод](https://sun4-11.userapi.com/impg/wqx20ZsUSkncBcO_eqrWCOeWcqmFk75jyoHLzg/4c0Ei7rElD8.jpg?size=1612x136&quality=96&sign=87a4f31b33cff7a81209c6559c93e001&type=album)
### 1.1.3
* Минимальный и максимальный хост в сети _12.167.38.4_ при масках _/8_, _11111111.11111111.00000000.00000000_, _255.255.254.0_
![Хосты](https://sun9-36.userapi.com/impg/f-YiMa00-2bI4hVnK1uUP09_Zm-SXAh8z5NuJw/H4ASkMCHcMM.jpg?size=1618x1050&quality=96&sign=50801fd9a5166c7cbeb4dcf0537920e2&type=album)
* Минимальный и максимальный хост в сети _12.167.38.4_ при маске _/4_
![Хосты](https://sun9-85.userapi.com/impg/DB4CyMBrUZaYMP6qcKX7AwvuSXZLCJRiJdgSFg/YfX2vuWR9Qc.jpg?size=1616x346&quality=96&sign=b48d58a953604bee99ef4453ce656995&type=album)

### 1.2.1 Localhost
* Чтобы понять, можно ли обратиться к приложению, работающему на **localhost** по ip, используем команду 
`ping <IP>`
![Пинг](https://sun9-75.userapi.com/impg/X2zs7fQ0Cn8xN-3lBBjytLNmu2fA9jaVMDVnjg/-2LP64tAtf0.jpg?size=1592x790&quality=96&sign=e87014700124af556fd62b15e1f09af4&type=album)
* Таким образом братиться можно к _127.0.0.2_ и к _127.1.0.1_.
### 1.3.1 Частные и публичные ip
* **частные ip** - _10.0.0.45, 10.10.10.10, 192.168.4.2, 172.20.250.4_, 172.16.255.255
* **публичные ip** - _134.43.0.2, 172.0.2.1, 192.172.0.1, 192.169.168.1_
* **Частные внутренние адреса** не маршрутизируются в Интернете и на них нельзя отправить трафик из Интернета, они работают только в пределах локальной сети.  
* К частным "серым" адресам относятся IP-адреса из следующих подсетей:
	-   От 10.0.0.0 до 10.255.255.255 с маской 255.0.0.0 или /8
	-   От 172.16.0.0 до 172.31.255.255 с маской 255.240.0.0 или /12
	-   От 192.168.0.0 до 192.168.255.255 с маской 255.255.0.0 или /16.
### 1.3.2
* **возможны** - _10.10.0.2_, _10.10.10.10_, _10.10.1.255_
* **невозможны** - _10.0.0.1, 10.10.100.1_

## Part 2. Статическая маршрутизация между двумя машинами
* С помощью клонирования в VirtualBox создана вторая виртуальная машина.
* Подняты обе виртуальные машины.
### 2.1.1 Получение сетевых интерфейсов
* С помощью команды `ip a` получены существующие сетевые интерфейсы для обеих машин.
![Первая машина](https://sun9-83.userapi.com/impg/aqQJ-eGOPWfQG1_BzJZ7sKb_SKn2bx3eOcIFsA/pDGjJHUPu2E.jpg?size=1938x714&quality=96&sign=5228719dc980261286b0fa14f93f0d70&type=album)
![Вторая машина](https://sun9-58.userapi.com/impg/cd_xZb_2tJWY37K6Q51jVUtXYbJGWMrr6wuK_g/s28dWyTN4qo.jpg?size=1938x656&quality=96&sign=6b25351abf6a709f48d510934e600ebc&type=album)
### 2.2.1 Описание сетевых интерфейсов
* Откроем файл конфигурации `network` с помощью команды `sudo vim /etc/netplan/00-installer-config.yaml`.
* Конфигурация машин:
![Конфигурация и применение](https://sun4-12.userapi.com/impg/sfTQEvY9ymomU5OY3aHyEMqzjLJVlNRbFP1sGw/K-WUSWkKGEY.jpg?size=1594x657&quality=96&sign=61c579441af1d9040c5c4ffdfc8aa5e4&type=album)
* Для перезапуска сервиса сети выполняем команду `sudo netplan apply`
### 2.2.2 Добавление статического маршрута
* Для каждой виртуальной машины был добавлен адаптер enp0s8 как `Внутренняя сеть`
* С помощью команды `sudo ip r a <address> dev <device>` можно вручную добавить статический маршрут.
![Результат добавления и пинг](https://sun4-15.userapi.com/impg/HNaDG-BCvoggOBbD-Ag8dhf3vHpRCx1RoeCBiA/z7GxeBYAVVQ.jpg?size=1600x679&quality=96&sign=d3b26e4880d04d356d18451553c7b5d1&type=album)
### 2.2.3 Добавление статического маршрута с сохранением
* Чтобы добавить статический маршрут с сохранением это необходимо прописать в конфиге.
* Изменение конфигов
![Измененные конфиги и применение](https://sun9-82.userapi.com/impg/rAb0Zh5Qe6RDcb1wvDIJ_mQgWUfldq9JkTFfpA/4JBzVaPAgeY.jpg?size=1596x677&quality=96&sign=15c0a215fcc82d5efbe915ef09a18731&type=album)
* Результат пингования
![ping](https://sun9-82.userapi.com/impg/rAb0Zh5Qe6RDcb1wvDIJ_mQgWUfldq9JkTFfpA/4JBzVaPAgeY.jpg?size=1596x677&quality=96&sign=15c0a215fcc82d5efbe915ef09a18731&type=album)

## Part 3. Утилита **iperf3**
#### 3.1. Скорость соединения
`8Mpbs = 1MB/s; 100 MB/s = 819200 Kbps; 1Gbps = 1024 Mbps`
#### 3.2. Утилита **iperf3**
* **Установка** - `sudo apt install iperf3`
* Запуск сервера на одной машине с помощью `iperf3 -s`
* Подключение к серверу на другой машине с помощью `iperf3 -c <ip>`
* Полученная скорость соединения:
![iperf3](https://sun9-57.userapi.com/impg/smM3iKflD75eejCSR5cc5MfaalmDdzB6_jlbdA/13KBv4-oVV4.jpg?size=1599x671&quality=96&sign=b35547b745bfc4a8e42a80f74e1f422b&type=album)

## Part 4. Сетевой экран
#### 4.1. Утилита **iptables**
* Для того чтобы создать имитацию `firewall` создадим **bash** скрипт с помощью `sudo vim /etc/firewall.sh`
* На ws1 применить стратегию когда в начале пишется запрещающее правило, а в конце пишется разрешающее правило 
* На ws2 применить стратегию когда в начале пишется разрешающее правило, а в конце пишется запрещающее правило
* Открываем порты для доступа с помощью `iptables -A INPUT -p tcp --dport <NUMBER> -j ACCEPT`
* Правила задаем с помощью `iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT(REJECT)`
* Написанные скрипты:
![Скрипты](https://sun4-16.userapi.com/impg/K6YR3pSUHlrKWzKdm6pGhad-UWl7EPBmn3PzmA/RAeNQNBqrOA.jpg?size=1597x354&quality=96&sign=5e2a1745c9f5f13a19e6424232988d0a&type=album)
* Результат пингования:
![Пинг](https://sun9-5.userapi.com/impg/hirYKIS5uHHMJ5vtUoAXZAFdKuiKUZQmaC1Ugw/U-tnc5fp-no.jpg?size=1590x237&quality=96&sign=f91dc8d6f5f9d26f11cf956f957c53c6&type=album)
#### 4.2. Утилита **nmap**
* Машина, с которой **"не пингуется"** - `ws1`.
* Пинг и пруф, что хост машины запущен:
![ping](https://sun9-36.userapi.com/impg/j2Qh4TAzet2bwo4hlokwuY6zfCEhhy0HVV1WqQ/SAO1gFSkzi4.jpg?size=798x654&quality=96&sign=0631785a31f050dc16e8b74929be4e0f&type=album)
## Part 5. Статическая маршрутизация сети
### 5.1. Настройка адресов машин
* Необходимо настроить адреса машин согласно схеме:
![Схема](https://sun9-55.userapi.com/impg/DXWwyy9TVPhtSoBZkxZm819rl5ppEDF-eIck0w/woyiFQ_uN9k.jpg?size=1431x702&quality=96&sign=033fa3c45cc392ca920b64ac8c2d5e5f&type=album)
* Конфиги `ws11 и ws21`:
![yaml](https://sun9-39.userapi.com/impg/Lt3n62qwm23oCVxwXLVNGN0KYyDsZd4gFzCLcA/MxOegNu_GI4.jpg?size=1596x375&quality=96&sign=fd45f763c5485091d05e2b8da4798e4e&type=album)
* Конфиг `ws22`:
![yaml](https://sun9-83.userapi.com/impg/WM43jc6Wk0YQ8B-AFf9V6u4qf5-dENPQvFIPZQ/1-0t2-2Zbo4.jpg?size=797x681&quality=96&sign=1f0fb0ab6ef466787866744b48feb971&type=album)
* Конфиги `r1 и r2`:
![yaml](https://sun9-80.userapi.com/impg/USzaINb5DLUaqxFWs4wGrDdJ13-0Ctg1fVH3cw/x9745FMpBKE.jpg?size=1617x516&quality=96&sign=1fac1324f385f64102c47bb4cb63c4b5&type=album)
* Результат пингования `ws22 с ws21`
![ping](https://sun9-78.userapi.com/impg/nT70SiyTJlPyPIPtU-7BSx0uzuyRlXT5LR1FZw/4QYv2yl_9gA.jpg?size=801x678&quality=96&sign=42e0d83e3b13fc4b71996d61624cb768&type=album)
* Результат пингования `r1 с ws11`
![ping](https://sun9-38.userapi.com/impg/rpmCrQml4LKPy4EXugcfOLB5Nkvn6i8TUa5-OA/vDYZ99F5OV0.jpg?size=797x654&quality=96&sign=fa2e26b299c7ca9fc223ca5db7ecf8c0&type=album)
* Проверка, что адреса машин заданы верно с помощью команды `ip -4 a`:
	- Для ws11 и ws21: ![вызов](https://sun1-93.userapi.com/impg/WmakGN0RAW4q2XlQmKQKurY_wPyrreYwnOUAeA/cFyKiM3R9tU.jpg?size=1590x429&quality=96&sign=797f41716d172b8e1c129f1c07d7d929&type=album)
	- Для ws22: ![вызов](https://sun1-94.userapi.com/impg/dmxI9IdYT2K2adwk4t-QE80JCCdPR6d-qx8dLA/pXVM9tOpqlQ.jpg?size=794x314&quality=96&sign=4fdb8215febaaa2855aeda233477dcf8&type=album)
	- Для r1 и r2: ![вызов](https://sun9-78.userapi.com/impg/2mujU4SjLHceqFKydDN56V5dav3rdYSTBp38Mg/cnbxdyh-nD4.jpg?size=1633x414&quality=96&sign=e829f0fbc51d4629f6449891a8ee05a9&type=album)
### 5.2. Включение переадресации IP-адресов.
* Для включения переадресации IP, выполняем команду на роутерах `sysctl -w net.ipv4.ip_forward=1`: 
![screen](https://sun9-34.userapi.com/impg/6y9QRf-GdFh--CwmL2Yq4B15dO_F03TVgcvKbg/gebqloFIamc.jpg?size=793x253&quality=96&sign=6573549d943557ef300bd56fc76096d2&type=album)
* `net.ipv4.ip_forward = 1` в конфиге `/etc/sysctl.config`. При использовании этого подхода, IP-переадресация включена на постоянной основе.
![cfg](https://sun9-31.userapi.com/impg/oEhPAyYz0ZMlADFknCOPVUgxSAu3DHa9kQTKgA/_X7gV1lIXro.jpg?size=946x655&quality=96&sign=446a53c9500369632bbee1d0989dc1a0&type=album)
### 5.3. Установка маршрута по-умолчанию
* Настроить маршрут по-умолчанию (шлюз) для рабочих станций. Для этого добавить `default` перед IP роутера в файле конфигураций:
![conf](https://sun9-31.userapi.com/impg/ZU-DwJ3YHLdwv-RLZSdPOOp3wktvurUKzO-MQw/nWhWGLqNJ3U.jpg?size=801x853&quality=96&sign=ae75f5cb5c6b046377784b83927a03df&type=album)
* Вызвать `ip r` и показать, что добавился маршрут в таблицу маршрутизации:
![ipr](https://sun4-16.userapi.com/impg/Mo5hahG3iPiU-UrSN-ffUMDjNFw8G9k10F89WQ/AQfXTL4ff7s.jpg?size=798x772&quality=96&sign=f8648594a730106502e19c1f5b91af19&type=album)
* Пропинговать с ws11 роутер r2 и показать на r2, что пинг доходит:
![ping](https://sun9-4.userapi.com/impg/fLpwCwxrEqWeufw67wpKv7OokbT_Kjxzh42UIA/ajZ74xBF1_0.jpg?size=796x438&quality=96&sign=87d3778fa1412c74cc26a8e42c86978a&type=album)
![пинг доходит](https://sun9-33.userapi.com/impg/wfr-lDkYY8gMzVSolSqoQvVqnGuHMRSq-3ldGw/pWgi2YBE9Z0.jpg?size=797x264&quality=96&sign=77d904aeca7d310d45c0153e3b91c515&type=album)
### 5.4. Добавление статических маршрутов
* Конфиги:
![conf](https://sun9-11.userapi.com/impg/ZD9ZZc0h05mW5gJnh2z6Arb_mWQmhjUdnLMHeA/8dsukjtAU6k.jpg?size=798x782&quality=96&sign=8c0f1f0711b3d0b59a00fcc997d08098&type=album)
* Вызвать `ip r` и показать таблицы с маршрутами на обоих роутерах:
![ipr](https://sun9-12.userapi.com/impg/bSByhGIWdZYohFFNBxgntDBBPQbrxg6UrCFpZQ/NR4YgGEKXtY.jpg?size=800x510&quality=96&sign=aec09d720ed2486317f4358586ec3a4a&type=album)

* Запустим команды `ip r list 10.10.0.0/[маска сети]` и `ip r list 0.0.0.0/0`:
![ipr_list](https://sun9-57.userapi.com/impg/iQu15mXnbMtNWgrviun8xfLgPvjcjTC3YSXVUg/8ihr89w8vig.jpg?size=795x186&quality=96&sign=0fd68fc6984250d19eb1f661f0d73495&type=album)
* Для адреса 10.10.0.0/[порт сети] был выбран маршрут, отличный от 0.0.0.0/0, потому что маска /18 описывает маршрут к сети точнее, в отличие от маски /0.
### 5.5. Построение списка маршрутизаторов
* Вывод команды `traceroute`:
![traceroute](https://sun9-83.userapi.com/impg/HqYWChw9V3Q7F-6aRecDFEl2d3AQWecsbVgvCQ/k4R4PVdAtA8.jpg?size=799x247&quality=96&sign=7c3d9ecc220c403914c516f6cf3eec09&type=album)
* `tcpdump -tnv -i` для первого роутера:
![dump](https://sun9-14.userapi.com/impg/hI0xk5KPHz_n8y16kquUny_SLxZUdswtfLmmfw/JpvDfV-JADc.jpg?size=799x475&quality=96&sign=5572240c19185ac7280c5730d95867be&type=album)
* Принцип работы: каждый пакет проходит на своем пути определенное количество узлов, пока достигнет своей цели. Причем, каждый пакет имеет свое время жизни. Это количество узлов, которые может пройти пакет перед тем, как он будет уничтожен. Этот параметр записывается в заголовке TTL, каждый маршрутизатор, через который будет проходить пакет уменьшает его на единицу. При TTL=0 пакет уничтожается, а отправителю отсылается сообщение Time Exceeded.Команда traceroute linux использует UDP пакеты. Она отправляет пакет с TTL=1 и смотрит адрес ответившего узла, дальше TTL=2, TTL=3 и так пока не достигнет цели. Каждый раз отправляется по три пакета и для каждого из них измеряется время прохождения. Пакет отправляется на случайный порт, который, скорее всего, не занят. Когда утилита traceroute получает сообщение от целевого узла о том, что порт недоступен трассировка считается завершенной.
### 5.6. Использование протокола **ICMP** при маршрутизации
* Запустить на r1 перехват сетевого трафика и одновременно пропинговать с ws11 несуществующий IP:
![dump](https://sun9-56.userapi.com/impg/9uDPAW17KdytKvx9uAC_3Bnlq0JHLDVPc7IcQw/8-4YPKBv5AE.jpg?size=798x422&quality=96&sign=0331c901421a810ccd0f3501c3f93361&type=album)
## Part 6. Динамическая настройка IP с помощью **DHCP**
* Конфигурация службы `DHCP` и `netplan ws21`:
![conf](https://sun9-24.userapi.com/impg/HNWW9W4BHfZP1YlD0Xwi75Ho0p-ht6Awq0-u4w/rUQka1XEF64.jpg?size=800x494&quality=96&sign=89edb8f1edba6b1ca1c5ae8663a63af7&type=album)
* Конфигурация `resolv.conf`:
![conf](https://sun9-27.userapi.com/impg/7ZlcEkU-Yw5m9Uyb5SnHmm-UWd0pUYyYGdUfQw/2ht79TIPD74.jpg?size=722x441&quality=96&sign=5ecaab989289bbbd26f000ac1271b70e&type=album)
* Результат пингования `ws21 с ws22` и вывод команды `ip a`:
![ping](https://sun9-13.userapi.com/impg/E0HphSHc-GrmyIgtJbpOWWC695H4fAaahhbWUg/AVxWSLGTbl0.jpg?size=800x684&quality=96&sign=1e6743140e62052fb338e501c0d8eb14&type=album)
* Конфигурация первого роутера:
![conf](https://sun9-80.userapi.com/impg/nawQgHvH4pSg1VOKUcs4Vj0ooPlekYKGdK7Y4w/hJwZVYHnS3Q.jpg?size=797x233&quality=96&sign=9eb4978f353272f3098408812b54307c&type=album)
* `resolv.conf` первого роутера:
![conf](https://sun9-68.userapi.com/impg/khn4dL9-SlGWQ3SOWSqoUO-Cqt8TDMCu3odw4A/Sja0tZbOmgA.jpg?size=797x364&quality=96&sign=a16aebce61a17c97b7c9efea78b2376b&type=album)
* `netplan ws11`:
![netplan](https://sun9-16.userapi.com/impg/mrMh6rdIpIEoEpLADj6VE_eRpMok95LrdIY75w/8eUiBvXv13Q.jpg?size=798x409&quality=96&sign=bd9a1efd3b9c981b4bce2eb1cb82a121&type=album)
* `ip a ws11`
![ipa](https://sun9-54.userapi.com/impg/--sfM3U8DP0WPgU3CVBBGoVSw6md_vRCN8aBcg/s_XKYzjdfCU.jpg?size=796x479&quality=96&sign=f7f51b96a6eb715727647f5d21e7506e&type=album)
* На ws21 используем команду `sudo dhclient enp0s8`. Предварительно `dhcp -r`.
* До:
![до](https://sun4-17.userapi.com/impg/Km9cC435Nv9IHTxNLni4M4Azksmn3OQqnlTvOQ/fH1IKdhlyEI.jpg?size=800x475&quality=96&sign=7a6eaa14ec80bfc08d9d042105c00766&type=album)
* После команды.
![после](https://sun4-10.userapi.com/impg/WKwuC3hDciZCfstk8iABbYf6FzjRzCTdQQst2Q/3D7kt1D82B8.jpg?size=801x426&quality=96&sign=905b2ab7886b64de29f74c28528ef051&type=album)
## Part 7. **NAT**
* Устанавливаем с помощью `sudo apt install apache2`.
* В файле _/etc/apache2/ports.conf_ на ws22 и r1 изменить строку `Listen 80` на `Listen 0.0.0.0:80`:
![ws22](https://sun9-48.userapi.com/impg/LIzHEaPnGsYs-nvlqjP9dE0AFlILP3VeGb_y8w/IEnWEufej8M.jpg?size=795x330&quality=96&sign=001bd6c62a9ffbf6db0c8674113e2167&type=album)
![r1](https://sun9-42.userapi.com/impg/7Bxc7Qyh7tHUUsIrqe29_kWglx-6Hb7gDAZjjA/poy6zxYn7HE.jpg?size=792x414&quality=96&sign=289eaf9fbb44381f84a08ae6edfd8efd&type=album)
* Запустить веб-сервер Apache командой `service apache2 start` на ws22 и r1:
![Запуск](https://sun9-4.userapi.com/impg/MroYpYljcI-oVFg5RotNORKYS-2ksOO3K32AKw/BdaexxXT02E.jpg?size=802x410&quality=96&sign=7914a9e9da0405c82fd8e2054c711537&type=album)
* Скрипт `firewall.sh на r2`:
![sh](https://sun9-20.userapi.com/impg/ilSr0bEBG8qU6LA5xgAyas2XgouqpJQfmHz0WQ/9jfMd0TsFH8.jpg?size=796x167&quality=96&sign=44b22e9fda41870bc26b717db0c107e9&type=album)
* Права на чтение и запуск, затем пингование ws22 с r1:
![screen](https://sun9-70.userapi.com/impg/PyyU0-0CRyDLUfdf2CQBLBJ3reikxyqNE-sCrg/jGcEW9wVHB0.jpg?size=803x331&quality=96&sign=62becfc9aaac71caf2c54b6cd9d41810&type=album)
* Разрешаем маршрутизацию всех пакетов. Результат пинга:
![ping](https://sun9-3.userapi.com/impg/nxNSKb4qFFLTw6qSBDErarruDIKucTC4IB4lXw/HEdsm3Aruxo.jpg?size=794x313&quality=96&sign=cfc5655779dabe420eca5afc9b9e576d&type=album)
* Включаем **SNAT**, а именно маскирование всех локальных _ip_ из локальной сети, находящейся за _r2_.
* Также включаем **DNAT** на порт 8080 машины r2 и добавляем к веб-серверу Apache, запущенному на ws22 доступ извне.
![sh](https://sun9-86.userapi.com/impg/JdbSlzCmNkIi33Zpj11WiT4NpJa94J5jfNCPqQ/pXgl-Wp9rYI.jpg?size=768x275&quality=96&sign=45ce70c1ddcdb42ed8cd9b5436ba1c8b&type=album)
* Проверка соединения по TCP для **SNAT** c помощью `telnet [address] [port]`:
![snat](https://sun9-45.userapi.com/impg/StNgo8A_qy-FiwhtHOWvTgifDJHzpiCXhWccZQ/DJn0F7stHc8.jpg?size=801x193&quality=96&sign=eb1d2dd02a7168af8f4466bbd9354c9a&type=album)
* Проверка соединения по TCP для **DNAT**, аналогично:
![dnat](https://sun9-82.userapi.com/impg/V6mNqIkzBqYmehi68FUUEwqwrL718VtR1Q67ZA/2iqEVdkhP5E.jpg?size=795x324&quality=96&sign=8a44cceb7c7fe87892e8a9cf385e4499&type=album)