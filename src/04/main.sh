#!/bin/bash

if [ $# -ne 0 ]
then
    echo "Please do not write any parametrs, chamge them in *.txt file"
else
    source config.txt

export par_1=$column1_background
export par_2=$column1_font_color
export par_3=$column2_background
export par_4=$column2_font_color

export HOSTNAME=$HOSTNAME
export TIMEZONE="$(timedatectl | grep Time | awk '{print $3 " " $4$5}')"
export USER=$USER
export OS="$(cat /etc/issue | awk '{print $1 $2}')"
export DATE="$(date +"%d %B %Y %T")"
export UPTIME="$(uptime -p)"
export UPTIME_SEC="$(cat /proc/uptime | awk '{print $2}')"
export IP="$(hostname -i | awk '{print $1}')"
export MASK="$(netstat -rn | awk 'FNR == 5 {print $3}')"
export GATEWAY="$(netstat -rn | awk 'FNR == 3 {print $2}')"
export RAM_TOTAL="$(cat /proc/meminfo | grep MemTotal | awk '{printf "%.3f GB\n", $2/1024/1024}')"
export RAM_USED="$(free | awk 'FNR == 2 {printf "%.3f GB\n", $3/1024/1024}')"
export RAM_FREE="$(cat /proc/meminfo | grep MemFree | awk '{printf "%.3f GB\n", $2/1024/1024}')"
export SPACE_ROOT="$(df /root/ | awk 'FNR == 2 {printf "%.3f MB\n", $2/1024}')"
export SPACE_ROOT_USED="$(df /root/ | awk 'FNR == 2 {printf "%.3f MB\n", $3/1024}')"
export SPACE_ROOT_FREE="$(df /root/ | awk 'FNR == 2 {printf "%.3f MB\n", $4/1024}')"

export no_color="\033[0m"

background_val=$par_1 # Столбец 1 справочная информация
foreground_val=$par_2 # Столбец 1 цвет шрифта
background_res=$par_3 # Столбец 2 справочная информация
foreground_res=$par_4 # Столбец 2 цвет шрифта


# выбор цвета
# определяются значения "по умолчанию" для каждой переменной, если они не указаны в файле config.txt
if [[ -z ${foreground_res} ]]
then 
export foreground_res="\033[34m"
foreground_res_color="Column 2 font color = default (blue)"
elif [[ foreground_res -eq 1 ]]
then
export foreground_res="\033[97m"
foreground_res_color="Column 2 font color = 1 (white)"
elif [[ foreground_res -eq 2 ]]
then
export foreground_res="\033[31m"
foreground_res_color="Column 2 font color = 2 (red)"
elif [[ foreground_res -eq 3 ]]
then
export foreground_res="\033[32m"
foreground_res_color="Column 2 font color = 3 (green)"
elif [[ foreground_res -eq 4 ]]
then
export foreground_res="\033[34m"
foreground_res_color="Column 2 font color = 4 (blue)"
elif [[ foreground_res -eq 5 ]]
then
export foreground_res="\033[35m"
foreground_res_color="Column 2 font color = 5 (purple)"
elif [[ foreground_res -eq 6 ]]
then
export foreground_res="\033[30m"
foreground_res_color="Column 2 font color = 6 (black)"
fi

if [[ -z ${background_val} ]]
then 
export background_val="\033[40m"
background_val_color="Column 1 background = default (black)"
elif [[ background_val -eq 1 ]]
then
export background_val="\033[107m"
background_val_color="Column 1 background = 1 (white)"
elif [[ background_val -eq 2 ]]
then
export background_val="\033[41m"
background_val_color="Column 1 background = 2 (red)"
elif [[ background_val -eq 3 ]]
then
export background_val="\033[42m"
background_val_color="Column 1 background = 3 (green)"
elif [[ background_val -eq 4 ]]
then
export background_val="\033[44m"
background_val_color="Column 1 background = 4 (blue)"
elif [[ background_val -eq 5 ]]
then
export background_val="\033[45m"
background_val_color="Column 1 background = 5 (purple)"
elif [[ background_val -eq 6 ]]
then
export background_val="\033[40m"
background_val_color="Column 1 background = 6 (black)"
fi

if [[ -z ${background_res} ]]
then 
export background_res="\033[41m"
background_res_color="Column 2 background = default (red)"
elif [[ background_res -eq 1 ]]
then
export background_res="\033[107m"
background_res_color="Column 2 background = 1 (white)"
elif [[ background_res -eq 2 ]]
then
export background_res="\033[41m"
background_res_color="Column 2 background = 2 (red)"
elif [[ background_res -eq 3 ]]
then
export background_res="\033[42m"
background_res_color="Column 2 background = 3 (green)"
elif [[ background_res -eq 4 ]]
then
export background_res="\033[44m"
background_res_color="Column 2 background = 4 (blue)"
elif [[ background_res -eq 5 ]]
then
export background_res="\033[45m"
background_res_color="Column 2 background = 5 (purple)"
elif [[ background_res -eq 6 ]]
then
export background_res="\033[40m"
background_res_color="Column 2 background = 6 (black)"
fi

if [[ -z ${foreground_val} ]]
then 
export foreground_val="\033[97m"
foreground_val_color="Column 1 font color = default (white)"
elif [[ foreground_val -eq 1 ]]
then
export foreground_val="\033[97m"
foreground_val_color="Column 1 font color = 1 (white)"
elif [[ foreground_val -eq 2 ]]
then
export foreground_val="\033[31m"
foreground_val_color="Column 1 font color = 2 (red)"
elif [[ foreground_val -eq 3 ]]
then
export foreground_val="\033[32m"
foreground_val_color="Column 1 font color = 3 (green)"
elif [[ foreground_val -eq 4 ]]
then
export foreground_val="\033[34m"
foreground_val_color="Column 1 font color = 4 (blue)"
elif [[ foreground_val -eq 5 ]]
then
export foreground_val="\033[35m"
foreground_val_color="Column 1 font color = 5 (purple)"
elif [[ foreground_val -eq 6 ]]
then
export foreground_val="\033[30m"
foreground_val_color="Column 1 font color = 6 (black)"
fi

# PRINT INFO

echo -e "${background_val}${foreground_val}HOSTNAME${no_color} = ${background_res}${foreground_res}$HOSTNAME${no_color}"
# echo "HOSTNAME = $HOSTNAME"

echo -e "${background_val}${foreground_val}TIMEZONE${no_color} = ${background_res}${foreground_res}$TIMEZONE${no_color}"
# echo "TIMEZONE = $TIMEZONE"

echo -e "${background_val}${foreground_val}USER${no_color} = ${background_res}${foreground_res}$USER${no_color}"
# echo "USER = $USER"

echo -e "${background_val}${foreground_val}OS${no_color} = ${background_res}${foreground_res}$OS${no_color}"
# echo "OS = $OS"

echo -e "${background_val}${foreground_val}DATE${no_color} = ${background_res}${foreground_res}$DATE${no_color}"
# echo "DATE = $DATE"

echo -e "${background_val}${foreground_val}UPTIME${no_color} = ${background_res}${foreground_res}$UPTIME${no_color}"
# echo "UPTIME = $UPTIME"

echo -e "${background_val}${foreground_val}UPTIME_SEC${no_color} = ${background_res}${foreground_res}$UPTIME_SEC${no_color}"
# echo "UPTIME_SEC = $UPTIME_SEC"

echo -e "${background_val}${foreground_val}IP${no_color} = ${background_res}${foreground_res}$IP${no_color}"
# echo "IP = $IP"

echo -e "${background_val}${foreground_val}MASK${no_color} = ${background_res}${foreground_res}$MASK${no_color}"
# echo "MASK = $MASK"

echo -e "${background_val}${foreground_val}GATEWAY${no_color} = ${background_res}${foreground_res}$GATEWAY${no_color}"
# echo "GATEWAY = $GATEWAY"

echo -e "${background_val}${foreground_val}RAM_TOTAL${no_color} = ${background_res}${foreground_res}$RAM_TOTAL${no_color}"
# echo "RAM_TOTAL = $RAM_TOTAL"

echo -e "${background_val}${foreground_val}RAM_USED${no_color} = ${background_res}${foreground_res}$RAM_USED${no_color}"
# echo "RAM_USED = $RAM_USED"

echo -e "${background_val}${foreground_val}RAM_FREE${no_color} = ${background_res}${foreground_res}$RAM_FREE${no_color}"
# echo "RAM_FREE = $RAM_FREE"

echo -e "${background_val}${foreground_val}SPACE_ROOT${no_color} = ${background_res}${foreground_res}$SPACE_ROOT${no_color}"
# echo "SPACE_ROOT = $SPACE_ROOT"

echo -e "${background_val}${foreground_val}SPACE_ROOT_USED${no_color} = ${background_res}${foreground_res}$SPACE_ROOT_USED${no_color}"
# echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"

echo -e "${background_val}${foreground_val}SPACE_ROOT_FREE${no_color} = ${background_res}${foreground_res}$SPACE_ROOT_FREE${no_color}"
# echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
echo -e "\n"
echo "$background_val_color"
echo "$foreground_val_color"
echo "$background_res_color"
echo "$foreground_res_color"
fi