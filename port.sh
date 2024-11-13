#!/bin/bash
NEW_PORT=2323

CONFIG_FILE="/etc/ssh/sshd_config"

cp $CONFIG_FILE ${CONFIG_FILE}.bak

sed -i "s/^#Port .*/Port $NEW_PORT/" $CONFIG_FILE
sed -i "s/^Port .*/Port $NEW_PORT/" $CONFIG_FILE

ufw allow $NEW_PORT/tcp

systemctl restart sshd

echo "Порт изменен на $NEW_PORT и разрешен в UFW."
