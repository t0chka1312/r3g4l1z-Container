FROM php:8.2-apache

# Instalar OpenSSH y sudo
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    mkdir -p /var/run/sshd

# Crear usuario r3g4l1z con shell y permisos sudo sobre chmod sin contraseña
RUN useradd -m -s /bin/bash r3g4l1z && \
    echo 'r3g4l1z ALL=(ALL) NOPASSWD: /bin/chmod' >> /etc/sudoers

# Configurar clave pública SSH para el usuario
COPY ssh/authorized_keys /home/r3g4l1z/.ssh/authorized_keys
RUN chown -R r3g4l1z:r3g4l1z /home/r3g4l1z/.ssh && \
    chmod 700 /home/r3g4l1z/.ssh && \
    chmod 600 /home/r3g4l1z/.ssh/authorized_keys

# Copiar la clave privada directamente a /home/r3g4l1z/.ssh y dejarla con permisos inseguros
COPY ssh/id_rsa /home/r3g4l1z/.ssh/id_rsa
RUN chown r3g4l1z:r3g4l1z /home/r3g4l1z/.ssh/id_rsa && \
    chmod 644 /home/r3g4l1z/.ssh/id_rsa && \
    chmod 755 /home/r3g4l1z/.ssh

# Crear flag pública
RUN echo "r3g4l1z{p4y_4tt3nt10n_t0_3xt3ns10ns}" > /home/r3g4l1z/flag.txt && \
    chown r3g4l1z:r3g4l1z /home/r3g4l1z/flag.txt && \
    chmod 644 /home/r3g4l1z/flag.txt

# Crear flag privada
RUN echo "r3g4l1z{p3rm1ssi0ns_4r3_v3ry_1mp0rt4nt}" > /home/r3g4l1z/.flag.txt && \
    chown r3g4l1z:r3g4l1z /home/r3g4l1z/.flag.txt && \
    chmod 400 /home/r3g4l1z/.flag.txt

# Copiar contenido web
COPY html/ /var/www/html/

# Crear carpeta de subidas con permisos
RUN mkdir -p /var/www/html/uploads && \
    chown -R www-data:www-data /var/www/html/uploads && \
    chmod -R 755 /var/www/html/uploads

# Activar mod_rewrite y .phtml como PHP
RUN a2enmod rewrite && \
    echo "AddType application/x-httpd-php .phtml" >> /etc/apache2/apache2.conf

# Exponer puertos
EXPOSE 80 22

# Comando de inicio
CMD service ssh start && apache2-foreground

# Flag final en /root (solo legible por root)
RUN echo "r3g4l1z{t4k3_c4r3_4b0ut_sud03rs}" > /root/root.txt && \
    chmod 600 /root/root.txt
