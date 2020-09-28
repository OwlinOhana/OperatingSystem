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
	-h) echo "Доступные команды 
		-a -авторы
		-ar - все доступны аргументы
                -readme - краткое описание проекта
		-example - примеры запуска " 
		read v
		if [ -n $v ]
		then
		case "$v" in
		-a) echo "
				Пинов Даниил Игоревич 
				Есикова Анастасия Дмитриевна
				Лепёхин Даниил Александрович"	
			;;
		-ar) echo " -h -I -U -In -K -L -M -e "
			;;
		-readme) echo "Функционал программы включает в себя:
			а)Вывод сетевых интерфейсов 
			б)Отключение/включение  интерфейса
			в)Установка IP/Mask/Gateway для определённого интерфейса
			г)Убийство процесса на заданном порту
			д)Отображение сетевой статиститки"
			;;
		-example) echo "Здесь что-то есть"
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
		echo "Отключить - d, вкючить - u" 
		read v
		if [ -n $v ]
		then
		case "$v" in
		-u) echo "Введите интерфейс, который хотите включить:"
			read int
			ifconfig $int up	
			;;
		-d) echo "Введите интерфейс, который хотите отключить:" 
			read int
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
		echo "Введите имя интерфейса сети " 
		read link
		echo "M - изменить маску Ip - изменить IP  G - изменить Gateway" 
		read v
		if [ -n $v ]
		then
		case "$v" in
		-M) echo "Введите маску " 
			read int
			ifconfig $link netmask $int 	
			;;
		-Ip) echo "Введите новый IP" 
			read int
			ifconfig $link $int
			;;
		-G) echo "Введите IP адрес шлюза, который нужно заменить:"
			read int
			ip route del default via $int dev $link
			echo "Введите новый IP адрес шлюза:"
			read int
			ip route add default via $int dev $link
			;;

		-*) echo "Неизвестное действие"
			;;
		esac
		else exit 1
		fi
		;;
	-K) 
		netstat -tulpn
		echo "Введите № порта " 
		read v
		if [ -n $v ]
		then
		lsof -i:$v #Эта команда возвращает список открытых процессов на этом порту.
		else exit 1
		echo "Введите № процесса" 
		read proc
		fi
		if [ -n $proc ]
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
