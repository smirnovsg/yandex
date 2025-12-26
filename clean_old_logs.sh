#!/bin/bash

if [ $# -lt 2 ]; then
    echo "При запуске добавьте аргументы : /папка/папка/logs + количество_дней"
    echo "Пример: ./clearn_old_logs /var/log 7"
    exit 1
fi

folder="$1"
days="$2"

files=$(find "$folder" -name "*.log" -mtime +$days 2>/dev/null)

if [ -z "$files" ]; then
    echo "Нет .log файлов старше $days дней"
    exit 0
fi

echo "Найдены файлы:"
echo "$files"

read -p "Удалить данные файлы? (y/n): " answer

if [ "$answer" = "y" ]; then
    echo "Удаляю..."
    for file in $files; do
        rm "$file"
        echo "Удален: $file"
    done
    echo "Готово!"
else
    echo "Отмена"
fi
