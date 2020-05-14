#!/bin/bash
# ------------------------------------------------------------------
#       Miguel Angel Gonzalez Sanchez
#       Stoyan Parvanov
#       Juan Antonio Lax Contreras
#
#          IES Ingeniero de la Cierva
#
#             Despliegue de entorno de desarrollo web php en Docker
#
# ------------------------------------------------------------------

read -p "¿Necesitas una configuración especial de nginx? si/NO " RESP

case $(echo $RESP | tr '[A-Z]' '[a-z]') in
        s|si) 	read -p "Pulse enter para abrir el editor y cambiar la configuración..."
                echo
            		nano ./nginx/nginx.conf
            		touch custom_nginx.dockerfile
            		echo "FROM nginx:latest" > ./custom_nginx.dockerfile
            		echo "COPY ./nginx/nginx.conf /etc/nginx/nginx.conf" >> ./custom_nginx.dockerfile
                echo "RUN rm -f /etc/nginx/conf.d/default.conf" >> ./custom_nginx.dockerfile
                echo "RUN mkdir /var/www" >> ./custom_nginx.dockerfile
	      ;;
        *)     	touch ./custom_nginx.dockerfile
		            echo "FROM nginx:latest" > ./custom_nginx.dockerfile
                echo "RUN rm -f /etc/nginx/conf.d/default.conf" >> ./custom_nginx.dockerfile
                echo "RUN mkdir /var/www" >> ./custom_nginx.dockerfile
	      ;;
    esac

echo "Preparando permisos para el servidor web, si sus ficheros no es encuentran en el directorio ./html, es el momento de hacerlo"
read -p "Pulse enter para continuar..."
echo
chown -R 101:101 ./html

docker-compose up -d
