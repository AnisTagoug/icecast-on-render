FROM ubuntu:20.04

# Installer Icecast
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y icecast2 && \
    apt-get clean

# Créer un utilisateur "icecast"
RUN useradd -m icecast

# Copier la config
COPY icecast.xml /etc/icecast2/icecast.xml

# Donner les permissions
RUN chown -R icecast:icecast /etc/icecast2

# Port d'écoute
EXPOSE 8000

# Lancer Icecast en tant qu'utilisateur non-root
USER icecast

CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
