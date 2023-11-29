#!/bin/bash

# получение системной информации
HOSTNAME=$(hostname)
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3, $4, "(" $6 ")"}')
USER=$(whoami)
OS=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2)
DATE=$(date "+%d %b %Y %T")
UPTIME=$(uptime -p | cut -c 4-)
UPTIME_SEC=$(uptime -s)
IP=$(hostname -I | awk '{print $1}')
MASK=$(ip addr show | grep "inet $IP" | awk '{print $2}')
GATEWAY=$(ip route show default | awk '/default/ {print $3}')

#  информация об использовании памяти и диска
RAM_TOTAL=$(free -m | awk '/^Mem/ {print $2/1024}')
RAM_USED=$(free -m | awk '/^Mem/ {print $3/1024}')
RAM_FREE=$(free -m | awk '/^Mem/ {print $4/1024}')
SPACE_ROOT=$(df -h / | awk '/\// {print $2}' | cut -d'G' -f1)
SPACE_ROOT_USED=$(df -h / | awk '/\// {print $3}' | cut -d'G' -f1)
SPACE_ROOT_FREE=$(df -h / | awk '/\// {print $4}' | cut -d'G' -f1)
 # Команды free -m и df -h / используются для получения статистики использования памяти и диска соответственно
 # Результаты этих команд обрабатываются с помощью утилит awk и cut для получения нужных значений. 
 
# печать системной информации
echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $(printf "%.3f" $RAM_TOTAL) GB"
echo "RAM_USED = $(printf "%.3f" $RAM_USED) GB"
echo "RAM_FREE = $(printf "%.3f" $RAM_FREE) GB"
echo "SPACE_ROOT = $(printf "%.2f" $SPACE_ROOT) MB"
echo "SPACE_ROOT_USED = $(printf "%.2f" $SPACE_ROOT_USED) MB"
echo "SPACE_ROOT_FREE = $(printf "%.2f" $SPACE_ROOT_FREE) MB"

# предложение сохранить данные в файл
read -p "Вы хотите сохранить эту информацию в файл? (Y/N) " answer

# ответ 
if [[ "$answer" == [yY] ]]; then
  # генерируем имя файла с текущей датой и временем
  filename=$(date +"%d_%m_%y_%H_%M_%S.status")
  
  # запись данных в файл
  {
    echo "HOSTNAME = $HOSTNAME"
    echo "TIMEZONE = $TIMEZONE"
    echo "USER = $USER"
    echo "OS = $OS"
    echo "DATE = $DATE"
    echo "UPTIME = $UPTIME"
    echo "UPTIME_SEC = $UPTIME_SEC"
    echo "IP = $IP"
    echo "MASK = $MASK"
    echo "GATEWAY = $GATEWAY"
    echo "RAM_TOTAL = $RAM_TOTAL"
    echo "RAM_USED = $RAM_USED"
    echo "RAM_FREE = $RAM_FREE"
    echo "SPACE_ROOT = $SPACE_ROOT"
    echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
    echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
  } > $filename
  
  echo "Данные, сохраненные в файл $filename"
else
  echo "Данные не сохранены"
fi
