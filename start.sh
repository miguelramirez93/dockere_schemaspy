#!/bin/bash
echo "Deteniendo los contenedores si estan en ejecucion..."
docker-compose down
echo "Creacion de carpetas necesarias del contenedor..."
if [ -f workspace/ ]; then
    echo "Las Carpetas ya fueron creadas..."
else
    mkdir -p workspace/htdocs
    echo "Carpetas creadas..."
fi
echo "Construyendo Contendor..."

    proxy="http://10.20.4.15:3128/"
    PROXY=$proxy docker-compose build

echo "ejecutando contenedor..."
docker-compose up -d

docker-compose run schemaspy sh -c 'java -jar schemaSpy.jar -t pgsql -o /output -dp postgresql-jre6.jar -host $db_host -port $db_port -u $db_user -p $db_pass -db $db_name -s $db_schema'

echo "El contenedor se esta ejecutando en segundo plano..."
