
if [ $# -eq 0 ]
  then
    echo "Comando inválido!"
    exit 1
fi

mysql -proot -e "drop database $1; create database $1"
zcat -f ./before-import.sql $2 ./after-import.sql | pv | mysql -proot $1