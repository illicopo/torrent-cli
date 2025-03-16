#!/bin/bash

DOWNLOAD_PATH="Додайсвійшляхдозавантаження"

while true; do
    link=$(whiptail --inputbox "Встав магнет-посилання:" 10 60 --title "Magnet link" 3>&1 1>&2 2>&3)

    if [[ $? -ne 0 ]]; then
        exit 0  # Вихід, якщо користувач натиснув "Скасувати"
    fi

    if [[ -z "$link" ]]; then
        whiptail --msgbox "Помилка: Магнет-посилання не може бути порожнім!" 10 50
        continue
    fi

    option=$(whiptail --title "Вибір дії" --menu "Що робити з цим торентом?" 15 60 5 \
        "1" "Дивитись торрент (mpv)" \
        "2" "Завантажити у $DOWNLOAD_PATH" \
        "3" "Вийти в термінал" \
        "4" "Повернутись до вводу магнет-лінка" 3>&1 1>&2 2>&3)

    case $option in
        1) 
            webtorrent --mpv "$link"
            ;;
        2) 
            webtorrent download -o "$DOWNLOAD_PATH" "$link"
            ;;
        3) 
            clear
            exit 0
            ;;
        4) 
            continue
            ;;
        *) 
            whiptail --msgbox "Некоректний вибір. Спробуй ще раз." 10 50
            ;;
    esac
done

