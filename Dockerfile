FROM ubuntu:20.04

# Installer Icecast
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y icecast2 && \
    apt-get clean

# Créer l'utilisateur icecast (ajouté au groupe existant)
RUN useradd -m -g icecast icecast

# Copier la configuration Icecast
COPY icecast.xml /etc/icecast2/icecast.xml

# Donner les droits à l'utilisateur sur les fichiers nécessaires
RUN chown -R icecast:icecast /etc/icecast2

# Créer un dossier de logs accessible (évite permission denied)
RUN mkdir -p /tmp/icecast-logs && chown -R icecast:icecast /tmp/icecast-logs

# Exposer le port Icecast
EXPOSE 8000

# Utiliser l'utilisateur non-root
USER icecast

# Lancer Icecast avec le fichier de configuration
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
