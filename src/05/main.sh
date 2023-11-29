#!/bin/bash

#  начало таймера
start_time=$(date +%s.%N)

# проверка  аргумента пути
if [ $# -eq 0 ]; then
    echo "Error: Directory path argument required."
    echo "       Usage: $0 <directory>"
    exit 1
fi

# dir_path присваивается значение первого аргумента командной строки, который представляет путь к директории
dir_path=$1

# проверка закрыт ли  путь "/"
if [ "${dir_path: -1}" != "/" ]; then
    echo "The directory path must end with '/'"
    exit 1
fi

# проверка, является ли предоставленный аргумент каталогом
if [ ! -d "$dir_path" ]; then
    echo "Error: '$dir_path' the specified directory does not exist."
    exit 1
fi

# общее количество папок (включая все вложенные)
# wc -l, подсчитывает количество строк (в данном случае - количество найденных директорий). Результат сохраняется в переменную total_folders.
total_folders=$(find "$dir_path" -type d | wc -l)

# топ-5 папок максимального размера, расположенных в порядке убывания (путь и размер)
# du -h, выводит размер каждой директории в указанной директории и ее поддиректориях
# sort -hr сортируется в порядке убывания
# head -n 5 выбираются первые 5 записей
top_folders=$(du -h "$dir_path"* | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}')

# общее количество файлов
total_files=$(find "$dir_path" -type f | wc -l)

# количество конфигурационных файлов (с расширением .conf), текстовых файлов, исполняемых файлов, файлов журнала (файлы с расширением .log), архивов, символических ссылок
# wc -l используется для подсчета количества найденных файлов
conf_files=$(find "$dir_path" -type f -name "*.conf" | wc -l)
txt_files=$(find "$dir_path" -type f -name "*.txt" | wc -l)
exe_files=$(find "$dir_path" -type f -executable | wc -l)
log_files=$(find "$dir_path" -type f -name "*.log" | wc -l)
archive_files=$(find "$dir_path" -type f \( -name "*.zip" -o -name "*.7z" -o -name "*.tar" -o -name "*.rar" -o -name "*.gz" \) | wc -l)
symlinks=$(find "$dir_path" -type l | wc -l)

# топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип)
# -type f указывает, что нужно искать только файлы
# du -h используется для вычисления размера каждого файла в удобочитаемом формате (с префиксами KB, MB и т. д.).
# sort -hr: сортируются в обратном порядке (-r) по размеру, используя удобочитаемые числа (-h).
# sed -n '1,10'p: Из всего списка файлов выбираются только первые 10 строк.
# номер строки (NR), путь к файлу ($2) и его размер ($1) и выводит их в нужном формате
# system для выполнения команды file -b --mime-type, которая определяет тип файла на основе его содержимого.
largest_files="$(find "$dir_path" -type f -exec du -h {} + | sort -hr | sed -n '1,10'p | awk '{printf("%d - %s, %s, ", NR, $2, $1); system("bash -c '\''file -b --mime-type "$2"'\''")}')"

# топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и хеш)
# -type f -executable указывает, что нужно искать только исполняемые файлы
# head -n 10 из всего списка файлов выбираются только первые 10 строк.
# md5sum, вычисляет хеш-сумму файла, а cut -d" " -f1 используется для извлечения только хеш-суммы из вывода.
largest_executable_files=$(find "$dir_path" -type f -executable -exec du -h {} +| sort -hr | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}')

# вывод на экран
echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top_folders"
echo "Total number of files = $total_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files = $txt_files"
echo "Executable files = $exe_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symlinks"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$largest_files"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$largest_executable_files"

# завершение таймера и рассчет время выполнения
# bc - утилита командной строки для производства арифметических вычислений
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)
echo "Script execution time (in seconds) = $elapsed_time"