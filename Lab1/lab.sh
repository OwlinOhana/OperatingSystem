#!/bin/bash

#В проекте должен обрабатываться аргумент "--help|-h" для вывода справки, в которой отображаются:
#Авторы;
#Все доступные аргументы;
#Краткое описание проекта;
#Примеры запуска.

IFS=$'\n'
echo "Доступные функции программы
-h - получить справку
-I - вывод сетевых интерфейсов 
-U - отключение/включение  интерфейса
-In - установка IP/Mask/Gateway для определённого интерфейса
-K - убийство процесса
-L - отображение сетевой статиститки
-e - exit"

while true
read var
do 
case "$var" in
	-h) read "Доступные команды 
		-a -авторы 
		-ar - все доступны аргументы
                 -readme - краткое описание проекта
		-example - примеры запуска " v
		if [ -n $v]
		then
		case "$v" in
		-a) echo "авторы"	
			;;
		-ar) echo " -h -I -U -In  -K -L -e"
			;;
		-readme) echo "Функционал программы включает в себя:
			а)вывод сетевых интерфейсов 
			б)отключение/включение  интерфейса
			в)установка IP/Mask/Gateway для определённого интерфейса
			г) убийство процесса на заданном порту
			д) отображение сетевой статиститки"
			;;
		-example) echo "здесь что-то есть"
			;;
		-*) echo "Неизвестное действие"
		    exit 1
		     ;;
		     esac
		fi
		;;
	-I) ip link show
		;;
	-U) ip link show
		read "Отключить - d, вкючить - u" v
		if [-n $v]
		then
		case "$v" in
		-u) read "введите интерфейс, который хотите включить" int
			ifconfig $int up	
			;;
		-d) read "введите интерфейс, который хотите отключить" int
			ifconfig $int down	
			;;
		-*) echo "Неизвестное действие"
			;;
		esac
		else exit 1
		fi
		;;

	-In) 
		#ifconfig eth0 192.168.33.42 netmask 255.255.0.
		#Измените два последних символа в MAC-адресе вашей сетевой карты.
		#ifconfig eth0 hw ether 08:00:27:ab:67:XX
		ifconfig
		read "Введите имя сети " link
		read "M - изменить маску Ip - изменить ip " v
		if [-n $v]
		then
		case "$v" in
		M) read "введите маску " int
			ifconfig $link netmask $int 	
			;;
		Ip) read "введите новый ip" int
			ifconfig $link $int
			;;
		-*) echo "Неизвестное действие"
			;;
		esac
		else exit 1
		fi
		;;
	-K) 
		netstat -tulpn
		read "Введите номер порта " v
		if [-n $v]
		then
		lsof -i:$v #Эта команда возвращает список открытых процессов на этом порту.
		else exit 1
		read "Введите номер процесса" proc
		fi
		if [-n $proc]
		then
		kill -9 $proc # насильственная смерть -9 #Чтобы освободить порт, убейте процесс, используя его(идентификатор процесса-75782)…
		else exit 1
		fi
		;;

	-L) #Отображение сетевой статистики  https://itproffi.ru/otslezhivanie-sostoyaniya-seti-v-linux-komanda-netstat/
		#https://itproffi.ru/otslezhivanie-sostoyaniya-seti-v-linux-komanda-netstat/
		netstat #netstat -a | more ||-atu
		;;
	-e) return 0
		;;

esac
done



#/sbin/route [-f] операция [-тип] адресат шлюз [dev] интерфейс
#Здесь аргумент операция может принимать одно из двух значений: add (маршрут добавляется) или delete (маршрут удаляется). Аргумент адресат может быть IP-адресом машины, IP-адресом сети или ключевым словом default . Аргумент шлюз  — это IP-адрес компьютера, на который следует пересылать пакет (этот компьютер должен иметь прямую связь с вашим компьютером).
#С помощью утилиты ifconfig вы также можете временно установить IP-адрес сетевого интерфейса. Этот IP-адрес будет использоваться до следующего цикла активации/деактивации сетевого интерфейса с помощью утилит ifup/ifdown или до следующей перезагрузки системы.


 
