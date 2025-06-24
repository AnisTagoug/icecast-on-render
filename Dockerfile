FROM ubuntu:20.04

# Installer Icecast
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y icecast2 && \
    apt-get clean

# Créer l'utilisateur icecast et l'ajouter au groupe existant "icecast"
RUN useradd -m -g icecast icecast

# Copier la config
COPY icecast.xml /etc/icecast2/icecast.xml

# Donner les permissions sur le fichier de config
RUN chown -R icecast:icecast /etc/icecast2

# Exposer le port d'écoute
EXPOSE 8000

# Utiliser l'utilisateur non-root
USER icecast

# Démarrer Icecast
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
