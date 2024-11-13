#!/bin/bash

read -p "Введите новый порт: " NEW_PORT

if ! [[ "$NEW_PORT" =~ ^[0-9]+$ ]] || [ "$NEW_PORT" -lt 1 ] || [ "$NEW_PORT" -gt 65535 ]; then
    echo "Ошибка: Порт должен быть числом от 1 до 65535."
    exit 1
fi

CONFIG_FILE="/etc/ssh/sshd_config"

cp $CONFIG_FILE ${CONFIG_FILE}.bak

sed -i "s/^#Port .*/Port $NEW_PORT/" $CONFIG_FILE
sed -i "s/^Port .*/Port $NEW_PORT/" $CONFIG_FILE

ufw allow $NEW_PORT/tcp

chmod 600 ~/.ssh/authorized_keys

sed -i.bak 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i.bak 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

systemctl restart ssh

echo "Порт изменен на $NEW_PORT и разрешен в UFW."
