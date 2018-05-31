echo "Avant de passer aux choses sérieuses procédons à une update"
sleep 0.5
echo -e "\033[33mUpdate en cours\033[0m"
sudo apt update >> log.txt
echo -e "\033[33mL'update est terminée !\033[0m"
sleep 0.5
echo -e "\033[33mVoici la liste des paquets installables : apache2 / php7.0 / mysql-server\033[0m"
echo "1) N'en installer qu'un "
echo "2) Tous les installer"
read choice_user
if [ "$choice_user" = "1" ]; then
    echo -e "\033[33mQuel paquet voulez-vous installer\033[0m"
    echo "1) apache2"
    echo "2) php7.0"
    echo "3) mysql-server"
    read packet_choose
    if [ "packet_choose" = "1" ]; then
        sudo apt-install -y apache2
        clear
        sleep 0.5
        echo -e "\033[33mvous avez installé apache2 avec succès\033[0m"
    elif [ "packet_choose" = "2" ]; then
        sudo apt-install -y php7.0
        clear
        sleep 0.5
        echo -e "\033[33mvous avez installé php7.0 avec succès\033[0m"
    elif [ "packet_choose" = "3" ]; then
        sudo apt-install -y mysql-server
        clear
        sleep 0.5
        echo -e "\033[33mvous avez installé mysql-server avec succès\033[0m"
        
    else
        echo -e "\033[31mVotre choix n'est pas valide\033[0m"
    fi
elif [ "$choice_user" = "2" ]; then
    sudo apt install apache2 php7.0 mysql-server
else 
    echo -e "\033[31mJe n\'ai pas compris votre demande\033[0m"
fi