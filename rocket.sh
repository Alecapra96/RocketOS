#!/bin/sh
sudo apt -y install dialog
# creamos la funcion DIALOG 
DIALOG=${DIALOG=dialog}


DIALOG --infobox "Bienvenido a RocketOS" 0 0 


#Actualizo el sistema
sudo apt -y install && sudo apt -y upgrade
sudo apt --fix-missing update

#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
$DIALOG --backtitle "Creado por : linkedin.com/in/alejandro-capra" \
	--title "Instalacion RocketOS" --clear \
        --radiolist "Selecciona con la tecla space la distro que deseas" 17 100 10 \
        "1"    "Debian 11" off \
        "2"    "Ubuntu" off \
        "3"   s "Arch" off  2> $tempfile
retval=$?
choice=`cat $tempfile`
case $retval in
  0)
    echo "Elegiste la opcion '$choice'"
    if [ $? -eq 0 ] 
    then
        case $choice in
        1)
            echo "Instalar RocketOS sobre debian"
            
                #Instalo dependencias bases
                sudo apt -y install --no-install-suggests --no-install-recommends xserver-xorg-core software-properties-common broadcom-sta-dkms cmake libfreetype6-dev libfontconfig1-dev xclip build-essential libx11-dev libxft-dev build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev x11-xserver-utils
                #Instalo BSPWM
                sleep 5 
                git clone https://github.com/baskerville/bspwm.git
                git clone https://github.com/baskerville/sxhkd.git
                cd bspwm/
                make
                sudo make install
                cd ../sxhkd/
                make
                sudo make install
                sleep 5 
                sudo apt -y install bspwm
                sleep 5 
                #Creo Los archivos de configuracion
                mkdir ~/.config
                mkdir ~/.config/bspwm
                mkdir ~/.config/sxhkd
                sleep 5 
                cd ../bspwm/
                cp examples/bspwmrc ~/.config/bspwm/
                chmod +x ~/.config/bspwm/bspwmrc
                cp examples/sxhkdrc ~/.config/sxhkd/
                sleep 5 
                #Instalo el script de startx
                sudo apt -y install xinit
                sleep 5 
                #Creo el archivo .xinitrc
                sudo cp ~/RocketOS-script/.xinitrc ~/
                sleep 5 
          
            ;;
        2)
            echo "Denegar login a todos los usuarios y permitir login de un grupo en particular"
      
            ;;
        3) 
            echo "Permitir login a todos los usuarios del realm/Dominio"
         
            ;;
    
        esac
    else
    dialog --infobox "No elegiste ninguna opcion" 5 82 ; sleep 3

    fi
 ;;
  1)
    echo "Cancel pressed.";;
  255)
    echo "ESC pressed.";;
esac
