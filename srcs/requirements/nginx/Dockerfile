FROM debian:buster

# Installe les logiciels dont nous avons besoin
RUN apt update
RUN apt install nginx -y 2> /dev/null
RUN apt install openssl -y 2> /dev/null

# Cree un dossier pour stocker les infos SSL
RUN mkdir -p /etc/nginx/ssl
# Cree un dossier pour stocker les fichiers de config NGINX
RUN mkdir -p /var/run/nginx

# Commande pour generer un certificat SSL
#  req		-> permet de generer des certificats autosignes en PKCS#10
#  -x509	-> permet de preciser le type de certificat (x509)
#  -nodes	-> permet de ne pas encrypter la cle privee, pour eviter un prompt pour le mdp
#  -out <path>	-> specifie le chemin de stockage du certificat
#  -keyout <p>	-> specifie le chemin de stockage de la cle du certificat
#  -subj	-> specifie les informations du certificat:
#			C: Country
#			ST: State or province name
#			O: Organization name
#			OU: Organization unit name
#			CN: Common Name
#			UID: Email Address
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=nguiard.42.fr/UID=nguiard"

# Met ma propre configuration nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# met a jour les droits sur le dossier 
RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

# Commande pour enable nginx
CMD [ "nginx", "-g", "daemon off;"]
