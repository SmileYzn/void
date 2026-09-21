#!/bin/bash

# Limpar
clear

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo -e "Esse script NÃO deve ser executado como root"
    exit
fi

# Abrir pasta do usuário
cd /home/$(whoami)

# Atualizar XBPS
sudo xbps-install -Syu xbps

# Atualizar Sistema
sudo xbps-install -Syu

# Atualizar o gerenciador de pacotes
sudo xbps-install -u xbps

# Buscar novas atualizações
sudo xbps-install -Syu

# Habilitar nonfree
sudo xbps-install -Syu void-repo-nonfree

# Atualizar Sistema
sudo xbps-install -Syu

# Pacotes base
sudo xbps-install -Syu \
7zip \
7zip-unrar \
alsa-firmware \
alsa-utils \
bash-completion \
blueman \
bluez \
fastfetch \
ffmpeg \
ffmpegthumbnailer \
git \
man \
nano \
numlockx \
pipewire \
power-profiles-daemon \
powertop \
unzip \
unrar \
xiccd \
xorg-apps \
xz \
zip

# Fontes 
sudo xbps-install -Syu \
adwaita-fonts \
dejavu-fonts-ttf \
font-adobe-source-code-pro \
font-adobe-source-serif-pro \
fonts-droid-ttf \
font-fira-otf \
font-fira-ttf \
font-firacode \
font-inconsolata-otf \
fonts-roboto-ttf \
noto-fonts-cjk \
noto-fonts-emoji \
noto-fonts-ttf \
noto-fonts-ttf-extra \
noto-fonts-ttf-variable \
ttf-opensans \
ttf-ubuntu-font-family

# Atualizar cache de fontes
sudo fc-cache -f -v

# XDG Utils
sudo xbps-install -Syu \
xdg-user-dirs \
xdg-user-dirs-gtk \
xdg-desktop-portal \
xdg-desktop-portal-gtk \
xdg-utils

# NTFS, CIFS, GVFS
sudo xbps-install -Syu \
cifs-utils \
ntfs-3g \
exfat-utils \
gvfs \
gvfs-afc \
gvfs-afp \
gvfs-cdda \
gvfs-goa \
gvfs-gphoto2 \
gvfs-mtp \
gvfs-smb

# XFCE4
sudo xbps-install -Syu \
xfce4-plugins \
xfce4-alsa-plugin \
xfce4-docklike-plugin \
xfce4-eyes-plugin \
xfce4-genmon-plugin \
xfce4-panel-profiles \
xfce4-pulseaudio-plugin \
xfce4-screenshooter

# Thunar
sudo xbps-install -Syu \
thunar-archive-plugin \
thunar-media-tags-plugin \
thunar-volman

# GStreamers
sudo xbps-install -Syu \
gstreamer1 \
gst-libav \
gst-plugins-bad1 \
gst-plugins-base1 \
gst-plugins-good1 \
gst-plugins-ugly1

# Extras
sudo xbps-install -Syu \
firefox \
firefox-i18n-pt-BR \
galculator \
gcolor3 \
gthumb \
lightdm-gtk-greeter-settings \
mugshot \
orage \
parole \
peek \
seahorse \
xarchiver

# Habilitar Bluetoth
sudo rfkill unblock bluetooth
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/bluetoothd /var/service/
sudo usermod -aG bluetooth $(whoami)

# Habilitar TRIM semanalmente
sudo mkdir -p /etc/cron.weekly
sudo printf '#!/bin/sh\n\nfstrim /' >> /etc/cron.weekly/fstrim

# Limpar dependências
sudo xbps-remove -foy

# Adicionar grupo autologin
sudo groupadd -r autologin

# Adicionar o usuário ao grupo
sudo gpasswd autologin -a $(whoami)

# Abrir pasta do usuário
cd /home/$(whoami)

# Criar pastas padrão
xdg-user-dirs-update

# Criar pastas
mkdir Desktop Documentos Downloads Imagens Modelos Músicas Projetos Rede Vídeos

# Alterar pastas
xdg-user-dirs-update --force --set DESKTOP /home/$(whoami)/Desktop
xdg-user-dirs-update --force --set DOCUMENTS /home/$(whoami)/Documentos
xdg-user-dirs-update --force --set DOWNLOAD /home/$(whoami)/Downloads
xdg-user-dirs-update --force --set PICTURES /home/$(whoami)/Imagens
xdg-user-dirs-update --force --set TEMPLATES /home/$(whoami)/Modelos
xdg-user-dirs-update --force --set MUSIC /home/$(whoami)/Músicas
xdg-user-dirs-update --force --set PROJECTS /home/$(whoami)/Projetos
xdg-user-dirs-update --force --set PUBLICSHARE /home/$(whoami)/Rede
xdg-user-dirs-update --force --set VIDEOS /home/$(whoami)/Vídeos

# Atualizar pastas padrão
xdg-user-dirs-update

# Remover pastas antigas
rm -rf Documents Music Pictures Projects Public Templates Videos Projects

# Limpar histórico
history -c && > ~/.bash_history

# Fim
exit
