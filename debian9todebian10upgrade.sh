#!/bin/bash
#CRIADO POR LEONARDO BOZZI @leobozzi
#ATUALIZADO EM 04/09/2019

if [[ $UID -ne 0 ]]; then
    echo "Por favor. Execute como root!"
    exit 1
fi

echo "ATUALIZANDO SEU DEBIAN 9 STRETCH PARA O DEBIAN 10 BUSTER"

echo "ATUALIZANDO O SISTEMA"
apt-get update && apt-get upgrade && apt-get dist-upgrade

echo "FAZENDO BACKUP DO ARQUVO SOURCES.LIST e DO CRONTAB"
echo "BACKUP DO SOURCE LIST"
cp /etc/apt/sources.list /etc/apt/sources.list.debian9 && cp /etc/crontab /etc/crontab.bkp

echo "SUBSTITUINDO TODOS AS REFERENCIAS DE STRETCH PARA BUSTER NO ARQUIVO SOURCES.LIST"
sed -i 's/stretch/buster/g' /etc/apt/sources.list


echo "AGORA ATUALIZANDO SEU DEBIAN COM NOVSO REPOSITÓRIOS, EM BREVE SERA O BUSTER. VAI DEMORAR !!!"
apt-get update && apt-get upgrade && apt-get dist-upgrade


reboot
