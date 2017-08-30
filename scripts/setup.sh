#!/bin/sh

################################################################################
# TO USE EXISTING APT CACHE SERVER, UNCOMMENT THE SECTION BELOW
# CACHE Client and Server Code from https://github.com/Ranboz/apt-cache-vagrant.
# Forked from https://github.com/rgl/apt-cache-vagrant
################################################################################
#set -eux
#sudo echo 'Acquire::http::Proxy "http://10.10.10.3:3142";' >/etc/apt/apt.conf.d/00aptproxy
#sudo echo 'Acquire::http::Proxy {download.oracle.com DIRECT;};' >> /etc/apt/apt.conf.d/00aptproxy
#sudo echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/00aptproxy
#echo 'Defaults env_keep += "DEBIAN_FRONTEND"' >/etc/sudoers.d/env_keep_apt
#chmod 440 /etc/sudoers.d/env_keep_apt
#export DEBIAN_FRONTEND=noninteractive

################################################################################
# Install the mandatory tools
################################################################################
# update the system
add-apt-repository -y ppa:webupd8team/java
apt-get update

export LANGUAGE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
locale-gen en_US.UTF-8
dpkg-reconfigure locales

#apt-get -y upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get -y -f upgrade

################################################################################
# Install the graphical environment
################################################################################

# force encoding
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# run GUI as non-privileged user
echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# install Ubuntu desktop and VirtualBox guest tools
#sudo apt-get install -y unity8-desktop-session-mir
#apt-get install -y xubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
#sudo apt-get install -y --no-install-recommends ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
sudo apt-get install -y ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
#apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# remove light-locker (see https://github.com/jhipster/jhipster-devbox/issues/54)
apt-get remove -y light-locker --purge

# change the default wallpaper
#wget https://jhipster.github.io/images/wallpaper-004-2560x1440.png -O /usr/share/xfce4/backdrops/jhipster-wallpaper.png
#wget https://raw.githubusercontent.com/jhipster/jhipster-devbox/master/images/jhipster-wallpaper.png -O /usr/share/xfce4/backdrops/jhipster-wallpaper.png
#sed -i -e 's/xubuntu-wallpaper.png/jhipster-wallpaper.png/' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml'

################################################################################
# Install the development tools
################################################################################

# install utilities
apt-get -y install vim git zip bzip2 fontconfig curl language-pack-en
#apt-get install -y gedit

# install Java 8 - oracle
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections 
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
apt-get -y install oracle-java8-installer

# install node.js
#added next to get around node repository error.
#from https://github.com/nodesource/distributions/issues/324
sudo rm -f /etc/apt/sources.list.d/ppa_chris_lea_node_js_*
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs unzip python g++ build-essential

# update npm
npm install -g npm

# install yarn
npm install -g yarn
su -c "yarn config set prefix /home/vagrant/.yarn-global" vagrant


# install yeoman grunt bower gulp
#su -c "yarn global add yo bower gulp" vagrant
su -c "yarn global add yo" vagrant

# install JHipster

su -c "yarn global add generator-jhipster@4.7.0" vagrant

# install JHipster UML
su -c "yarn global add jhipster-uml@2.0.3" vagrant

#export PATH="$PATH:`yarn global bin`:$HOME/.config/yarn/global/node_modules/.bin"


# install Ubuntu Make - see https://wiki.ubuntu.com/ubuntu-make

add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make
add-apt-repository -y ppa:webupd8team/brackets
apt-get update
apt-get -y -f upgrade

apt-get install -y ubuntu-make

#- Installed Chrome
sudo apt-get install -y libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

#- Installed Maven
sudo apt-get install -y maven

#- Installed Brackets
sudo apt-get install -y brackets

# install Chromium Browser
#apt-get install -y chromium-browser

# install MySQL Workbench
apt-get install -y mysql-workbench

# install PgAdmin
#apt-get install -y pgadmin3

# install Heroku toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh


# install Guake
#apt-get install -y guake
#cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

# install jhipster-devbox
git clone git://github.com/jhipster/jhipster-devbox.git /home/vagrant/jhipster-devbox
chmod +x /home/vagrant/jhipster-devbox/tools/*.sh

# install zsh
#apt-get install -y zsh

# install oh-my-zsh
#git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
#cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
#chsh -s /bin/zsh vagrant
#echo 'SHELL=/bin/zsh' >> /etc/environment

# install jhipster-oh-my-zsh-plugin
#git clone https://github.com/jhipster/jhipster-oh-my-zsh-plugin.git /home/vagrant/.oh-my-zsh/custom/plugins/jhipster
#sed -i -e "s/plugins=(git)/plugins=(git docker docker-compose jhipster)/g" /home/vagrant/.zshrc
#echo 'export PATH="$PATH:/usr/bin:/home/vagrant/.yarn-global/bin:/home/vagrant/.yarn/bin:/home/vagrant/.config/yarn/global/node_modules/.bin"' >> /home/vagrant/.zshrc

# change user to vagrant
#chown -R vagrant:vagrant /home/vagrant/.zshrc /home/vagrant/.oh-my-zsh

# install Visual Studio Code
su -c 'umake ide visual-studio-code /home/vagrant/.local/share/umake/ide/visual-studio-code --accept-license' vagrant

# Install eclipse
su -c 'umake ide eclipse-jee /home/vagrant/.local/share/umake/ide/eclipse-jee' vagrant

# fix links (see https://github.com/ubuntu/ubuntu-make/issues/343)
sed -i -e 's/visual-studio-code\/code/visual-studio-code\/bin\/code/' /home/vagrant/.local/share/applications/visual-studio-code.desktop

# disable GPU (see https://code.visualstudio.com/docs/supporting/faq#_vs-code-main-window-is-blank)
sed -i -e 's/"$CLI" "$@"/"$CLI" "--disable-gpu" "$@"/' /home/vagrant/.local/share/umake/ide/visual-studio-code/bin/code

#install IDEA community edition
#su -c 'umake ide idea /home/vagrant/.local/share/umake/ide/idea' vagrant

# increase Inotify limit (see https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit)
#echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/60-inotify.conf
#sysctl -p --system

#Needs all of this for JHIPSTER
export PATH="$PATH:`yarn global bin`:/home/vagrant/.config/yarn/global/node_modules/.bin:/usr/bin:/home/vagrant/.yarn-global/bin:/home/vagrant/.yarn/bin"
echo "export PATH='$PATH:`yarn global bin`:/home/vagrant/.config/yarn/global/node_modules/.bin:/usr/bin:/home/vagrant/.yarn-global/bin:/home/vagrant/.yarn/bin:/home/vagrant/.local/share/umake/ide/eclipse-jee
'" >> /home/vagrant/.profile


# install latest Docker
curl -sL https://get.docker.io/ | sh

# install latest docker-compose
curl -L "$(curl -s https://api.github.com/repos/docker/compose/releases | grep browser_download_url | head -n 4 | grep Linux | cut -d '"' -f 4)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# configure docker group (docker commands can be launched without sudo)
usermod -aG docker vagrant

#sudo useradd dev && sudo passwd dev && sudo adduser dev sudo && sudo mkdir /home/dev
#echo "dev:dev" | sudo chpasswd

# fix ownership of home
mkdir /home/vagrant/Desktop
chown -R vagrant:vagrant /home/vagrant/

# change the default wallpaper
sudo wget https://iso.500px.com/wp-content/uploads/2016/01/bestof.jpg -O /home/vagrant/background.jpg
echo "[ -f /home/vagrant/background.jpg ] && gsettings set org.gnome.desktop.background picture-uri 'file:///home/vagrant/background.jpg' || echo 'Background Not found'" >> /home/vagrant/.profile
#echo "gsettings set org.gnome.desktop.background picture-uri 'file:///home/vagrant/background.jpg'" >> /home/vagrant/.profile

# clean the box
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
#dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
#rm -f /EMPTY

# Needed for to stop error popup from apport.  Comment out to keep.
sudo sed -i 's/1/0/g' /etc/default/apport


##### ADD ICONS
echo '[Desktop Entry]
Version=1.0
Name=Google Chrome
Exec=/usr/bin/google-chrome-stable %U
Terminal=false
Icon=google-chrome
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml_xml;image/webp;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;
Actions=NewWindow;NewPrivateWindow;

[Desktop Action NewWindow]
Name=New Window
Exec=/usr/bin/google-chrome-stable' > /home/vagrant/Desktop/google-chrome.desktop
chmod +x /home/vagrant/Desktop/google-chrome.desktop

echo '[Desktop Entry]
Version=1.0
Name=Gedit
Exec=/usr/bin/gedit %U
Terminal=false
Icon=
Type=Application
Categories=
MimeType=text/html;text/xml;application/xhtml_xml;
Actions=NewWindow;NewPrivateWindow;

[Desktop Action NewWindow]
Name=New Window
Exec=/usr/bin/gedit' > /home/vagrant/Desktop/gedit.desktop
chmod +x /home/vagrant/Desktop/gedit.desktop

echo '[Desktop Entry]
Version=1.0
Name=Eclipse-JEE
Exec=/home/vagrant/.local/share/umake/ide/eclipse-jee/eclipse %U
Terminal=false
Icon=/home/vagrant/.local/share/umake/ide/eclipse-jee/icon.xpm
Type=Application
Categories=
MimeType=text/html;text/xml;application/xhtml_xml;
Actions=NewWindow;NewPrivateWindow;

[Desktop Action NewWindow]
Name=New Window
Exec=/home/vagrant/.local/share/umake/ide/eclipse-jee/eclipse' > /home/vagrant/Desktop/eclipse.desktop
chmod +x /home/vagrant/Desktop/eclipse.desktop

reboot
