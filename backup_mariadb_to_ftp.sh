#!/bin/bash

# Váriaveis do servidor FTP para onde o backup serah enviado
HOST_FTP="ftp.xxxxxx"
USUARIO_FTP="xxxxxxx"
SENHA_FTP="xxxxxxxx"
REMOTE_FOLDER="/backup/backup_mariadb"

#Variaveis de banco de Dados, data e hora
SERVER="localhost"                    #Servidor mariadb
LOGIN="glpi"     #login da base
PW="xxxxxxxx"                        #senha
NAME_TEMP="all"                          #nome do arquivo temporário mysql
BK="/bkp"                #Diretório para salvar arquivos de backup
NW=$(date "+%d%m%Y")              #Buscar pela data
HR=$(date "+%H-%M")              #Busca Hora
NB=20                             #número de cópias do banco de dados
HS="backup"                      #nome do arquivo compactado
function backup()
{
 echo "Realizando backup do server01 MariaDB on line para FTP"
 mysqldump -u$LOGIN -p$PW -h$SERVER --add-drop-table --quote-names --all-databases --add-drop-database > "$HOME/$HS-$NW-$HR.sql"
 echo "Compactando arquivo de backup $HS-$NW-$HR.sql.gz ..."
 gzip -f "$HOME/"$HS-$NW-$HR.sql
 cp -f "$HOME/"$HS-$NW-$HR.sql.gz "$BK/$HS-$NW-$HR.sql.gz"

 a=0
 b=$(ls -t $BK)
 c=$NB

 for arq in $b; do
   a=$(($a+1))
   if [ "$a" -gt $c ];  then
     rm -f "$bk/$arq"
   fi
 done
}
backup

#  Dados do arquivo de backup - mude se desejar
ARQUIVO="$HS-$NW-$HR.sql.gz"

# Acessa o FTP e envia os arquivos de backup
echo "ENVIANDO BANCO DE DADOS PARA A PASTA FTP REMOTA"

ftp -pinv $HOST_FTP << END_SCRIPT
user $USUARIO_FTP $SENHA_FTP
bin
lcd $BK
cd $REMOTE_FOLDER
put $ARQUIVO
bye
END_SCRIPT
