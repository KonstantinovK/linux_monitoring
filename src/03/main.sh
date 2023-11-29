#!/bin/bash
# функция  отображения информации о значении цвета
print_color_info() {
    echo "1 - white"
    echo "2 - red"
    echo "3 - green"
    echo "4 - blue"
    echo "5 - purple"
    echo "6 - black"
}

# функция для получения строки цвета для названия значения
get_label_color() {
    case $1 in
        1) echo -ne "\033[48;5;15m\033[38;5;${2}m";;
        2) echo -ne "\033[48;5;1m\033[38;5;${2}m";;
        3) echo -ne "\033[48;5;2m\033[38;5;${2}m";;
        4) echo -ne "\033[48;5;4m\033[38;5;${2}m";;
        5) echo -ne "\033[48;5;5m\033[38;5;${2}m";;
        6) echo -ne "\033[48;5;0m\033[38;5;${2}m";;
    esac
}

# функция  получения строки цвета для значений после знака '='
get_value_color() {
    case $1 in
        1) echo -ne "\033[48;5;15m\033[38;5;${2}m";;
        2) echo -ne "\033[48;5;1m\033[38;5;${2}m";;
        3) echo -ne "\033[48;5;2m\033[38;5;${2}m";;
        4) echo -ne "\033[48;5;4m\033[38;5;${2}m";;
        5) echo -ne "\033[48;5;5m\033[38;5;${2}m";;
        6) echo -ne "\033[48;5;0m\033[38;5;${2}m";;
    esac
}

# проверка наличия 4 параметров
if [[ $# -ne 4 ]]; then
    echo "Ожидаются 4 числовых параметра от 1 до 6."
    print_color_info
    exit 1
fi
# проверка, что все параметры являются числами
for arg in "$@"
do
    if ! [[ $arg =~ ^[1-6]$ ]]; then
        echo "Ошибка: введите корректное значение параметра."
        print_color_info
        exit 1
    fi
done
# проверка, что цвета шрифта и фона одного столбца не совпадают
if [[ $1 == $2 ]]; then
    echo "Ошибка: цвета шрифта и фона для названий значений не должны совпадать."
    print_color_info
    exit 1
fi
if [[ $3 == $4 ]]; then
    echo "Ошибка: цвета шрифта и фона для значений после знака '=' не должны совпадать."
    print_color_info
    exit 1
fi
# получение значений для вывода
HOSTNAME=$(uname -n)
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{ print $3 " " $4 }')
USER=$(whoami)
OS=$(uname -sr)
DATE=$(date +"%d %B %Y %T")
UPTIME=$(uptime -p | sed -e 's/up //' -e 's/minutes/min/' -e 's/hours/hrs/' -e 's/minute/min/' -e 's/hour/hrs/')
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}' | cut -d '.' -f1)
IP=$(ip route get 8.8.8.8 | head -1 | awk '{print $7}')
MASK=$(ip -o -f inet addr show | grep $IP | awk '{print $4}' | cut -d'/' -f2)
GATEWAY=$(ip r | grep default | awk '{print $3}')
RAM_TOTAL=$(free -h --si | grep Mem | awk '{printf "%.3f", $2/1024}')
RAM_USED=$(free -h --si | grep Mem | awk '{printf "%.3f", $3/1024}')
RAM_FREE=$(free -h --si | grep Mem | awk '{printf "%.3f", $4/1024}')
SPACE_ROOT=$(df -h | grep "/$" | awk '{printf "%.2f", $2}')
SPACE_ROOT_USED=$(df -h | grep "/$" | awk '{printf "%.2f", $3}')
SPACE_ROOT_FREE=$(df -h | grep "/$" | awk '{printf "%.2f", $4}')
# вывод данных с заданными параметрами цвета
echo -e "$(get_label_color $1 $2)HOSTNAME $(get_value_color $3 $4)= $HOSTNAME\033[0m"
echo -e "$(get_label_color $1 $2)TIMEZONE $(get_value_color $3 $4)= $TIMEZONE\033[0m"
echo -e "$(get_label_color $1 $2)USER $(get_value_color $3 $4)= $USER\033[0m"
echo -e "$(get_label_color $1 $2)OS $(get_value_color $3 $4)= $OS\033[0m"
echo -e "$(get_label_color $1 $2)DATE $(get_value_color $3 $4)= $DATE\033[0m"
echo -e "$(get_label_color $1 $2)UPTIME $(get_value_color $3 $4)= $UPTIME\033[0m"
echo -e "$(get_label_color $1 $2)UPTIME_SEC $(get_value_color $3 $4)= $UPTIME_SEC\033[0m"
echo -e "$(get_label_color $1 $2)IP $(get_value_color $3 $4)= $IP\033[0m"
echo -e "$(get_label_color $1 $2)MASK $(get_value_color $3 $4)= $MASK\033[0m"
echo -e "$(get_label_color $1 $2)GATEWAY $(get_value_color $3 $4)= $GATEWAY\033[0m"
echo -e "$(get_label_color $1 $2)RAM_TOTAL $(get_value_color $3 $4)= $RAM_TOTAL GB\033[0m"
echo -e "$(get_label_color $1 $2)RAM_USED $(get_value_color $3 $4)= $RAM_USED GB\033[0m"
echo -e "$(get_label_color $1 $2)RAM_FREE $(get_value_color $3 $4)= $RAM_FREE GB\033[0m"
echo -e "$(get_label_color $1 $2)SPACE_ROOT $(get_value_color $3 $4)= $SPACE_ROOT MB\033[0m"
echo -e "$(get_label_color $1 $2)SPACE_ROOT_USED $(get_value_color $3 $4)= $SPACE_ROOT_USED MB\033[0m"
echo -e "$(get_label_color $1 $2)SPACE_ROOT_FREE $(get_value_color $3 $4)= $SPACE_ROOT_FREE MB\033[0m"
# сбросо цвета терминала  на исходные
echo -e "\033[0m"