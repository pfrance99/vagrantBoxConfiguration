echo "Vous êtes maintenant connecté à votre machine virtuelle en ssh"
sleep 0.5
echo "Avant de passer aux choses sérieuses procédons à une update"
sleep 0.5
sudo apt update
clear
echo "L'update est terminée !"
sleep 0.5
echo "Voici la liste des paquets installables : apache2 / php7.0 / mysql-server"
echo "1) N'en installer qu'un "
echo "2) Tous les installer"
read choice_user
if [ "$choice_user" = "1" ]; then
    echo "Quel paquet voulez-vous installer"
    echo "1) apache2"
    echo "2) php7.0"
    echo "3) mysql-server"
    read packet_choose
    if [ "packet_choose" = "1" ]; then
        sudo apt-install -y apache2
        clear
        sleep 0.5
        echo"vous avez installé apache2 avec succès"
    elif [ "packet_choose" = "2" ]; then
        sudo apt-install -y php7.0
        clear
        sleep 0.5
        echo"vous avez installé php7.0 avec succès"
    elif [ "packet_choose" = "3" ]; then
        sudo apt-install -y mysql-server
        clear
        sleep 0.5
        echo"vous avez installé mysql-server avec succès"
    else
        echo "Votre choix n'est pas valide"
    fi
elif [ "$choice_user" = "2" ]; then
    sudo apt install apache2 php7.0 mysql-server
else 
    echo -e "Je n\'ai pas compris votre demande"
fi