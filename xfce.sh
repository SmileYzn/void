#!/bin/bash

# Limpar
clear

# Usuário padrão (UID 1000)
USUARIO=$(id -nu 1000)

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo -e "Esse script NÃO deve ser executado como ${USER}"
    exit
fi

# Abrir pasta do usuário
cd /home/$USUARIO

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

# Pacotes base
sudo xbps-install -Syu 7zip 7zip-unrar alsa-firmware alsa-utils bash-completion blueman fastfetch ffmpegthumbnailer git man nano pipewire power-profiles-daemon powertop system-config-printer unzip unrar xz zip

# Adwaita
sudo xbps-install -Syu adwaita-fonts adwaita-icon-theme

# Fontes Adobe
sudo xbps-install -Syu font-adobe-source-code-pro font-adobe-source-serif-pro

# Fontes Noto Sans
sudo xbps-install -Syu noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-ttf-variable

# Fontes Fira Sans, Fira Code
sudo xbps-install -Syu font-fira-otf font-fira-ttf font-firacode

# Fontes Droid Sans, Open Sans, Roboto, ubuntu
sudo xbps-install -Syu fonts-droid-ttf ttf-opensans fonts-roboto-ttf ttf-ubuntu-font-family

# Atualizar cache de fontes
sudo fc-cache -f -v

# XDG Utils
sudo xbps-install -Syu xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils

# XORG
sudo xbps-install -Syu numlockx xiccd xorg-apps

# NTFS, CIFS, GVFS
sudo xbps-install -Syu cifs-utils ntfs-3g exfat-utils gvfs gvfs-afc gvfs-afp gvfs-cdda gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-smb

# XFCE4
sudo xbps-install -Syu xfce4-plugins xfce4-alsa-plugin xfce4-docklike-plugin xfce4-eyes-plugin xfce4-genmon-plugin xfce4-panel-profiles

# Thunar
sudo xbps-install -Syu thunar-archive-plugin thunar-media-tags-plugin thunar-volman

# Firefox
sudo xbps-install -Syu firefox firefox-i18n-pt-BR

# GStreamers
sudo xbps-install -Syu gstreamer1 gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1

# Extras
sudo xbps-install -Syu catfish dconf-editor gcolor3 gparted gthumb lightdm-gtk-greeter-settings mate-calc mugshot orage parole peek seahorse simple-scan xarchiver zeitgeist

# Bluetoth, CUPS
sudo xbps-install -Syu blueman bluez cups libspa-bluetooth

# Habilitar Bluetoth
sudo rfkill unblock bluetooth
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/bluetoothd /var/service/
sudo usermod -aG bluetooth $USER

# Habilitar TRIM semanalmente
echo "#!/bin/sh" | sudo tee -a "/etc/cron.weekly/fstrim"
echo "fstrim /" | sudo tee -a "/etc/cron.weekly/fstrim"

#sudo sed -i '/^[^#]*\/ /s/\(defaults\)/\1,discard/' /etc/fstab

# Limpar dependências
sudo xbps-remove -foy

# Adicionar grupo autologin
sudo groupadd -r autologin

# Adicionar o usuário ao grupo
sudo gpasswd autologin -a ${USUARIO}

# Abrir pasta do usuário
cd /home/$USUARIO

# Criar pastas padrão
xdg-user-dirs-update

# Criar pastas
mkdir Desktop Downloads Modelos Rede Documentos Músicas Imagens Vídeos

# Alterar pastas
xdg-user-dirs-update --force --set DESKTOP /home/$USUARIO/Desktop
xdg-user-dirs-update --force --set DOWNLOAD /home/$USUARIO/Downloads
xdg-user-dirs-update --force --set TEMPLATES /home/$USUARIO/Modelos
xdg-user-dirs-update --force --set PUBLICSHARE /home/$USUARIO/Rede
xdg-user-dirs-update --force --set DOCUMENTS /home/$USUARIO/Documentos
xdg-user-dirs-update --force --set MUSIC /home/$USUARIO/Músicas
xdg-user-dirs-update --force --set PICTURES /home/$USUARIO/Imagens
xdg-user-dirs-update --force --set VIDEOS /home/$USUARIO/Vídeos

# Atualizar pastas padrão
xdg-user-dirs-update

# Remover pastas antigas
rm -rf Documents Music Pictures Public Templates Videos

# Fim
exit
