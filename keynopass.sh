#!/bin/bash

chmod 600 ~/.ssh/authorized_keys

sed -i.bak 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i.bak 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

sudo systemctl restart sshd

echo "Настройки SSH обновлены и сервер перезапущен."
