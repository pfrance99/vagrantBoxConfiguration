#!/usr/bin/env bash clear 

echo "" > log.txt
echo "Bienvenue dans 'Vagrant Box Configuration'"
sleep 0.5
j="0"
while [ "$j" != "1" ]; do
    echo "Avez-vous déja installé Vagrant et VirtualBox ? O/N"
    read response_vm_vbox
    if [ "$response_vm_vbox" = "O" ] || [ "$response_vm_vbox" = "o" ]; then
        j="1"
        echo -e "\033[32mTrès bien, commencons sans plus attendre !\033[0m"
        sleep 1
        i="0"
        while [ "$i" != "1" ]; do
            clear
            echo Quelle Machine Virtuelle voulez-vous utiliser?
            echo 1: ubuntu/xenial64
            echo 2: ubuntu/xenial64
            read vm_base_response

            if [ "$vm_base_response" = "1" ]; then
                vm_base_final_response="ubuntu/xenial64"
                i="1"
            elif [ "$vm_base_response" = "2" ]; then
                vm_base_final_response="ubuntu/xenial64"
                i="1"
            else
                echo -e "\033[31mErreur, veuillez choisir entre 1 et 2\033[0m"
            fi
        done
        sleep 0.5
        clear
        echo "Comment voulez-vous appeler le dossier synchronisé?"
        sleep 0.5
        echo -e "\033[33mNous vous recommandons 'data'\033[0m"
        read synced_folder_response
        echo "
        Vagrant.configure(\"2\") do |config|
        config.vm.box = \"$vm_base_final_response\"
        config.vm.network \"private_network\", ip: \"192.168.33.10\"
        config.vm.synced_folder \"./$synced_folder_response\", \"/var/www/html\", type: \"virtualbox\"end" > Vagrantfile;
        mkdir $synced_folder_response;
        cp scriptssh.sh $synced_folder_response
        sleep 0.5
        clear
        echo -e "\033[33mEt c'est parti la machine virtuelle démarre, veuillez patienter (cela peut prendre quelques minutes)!\033[0m"
        vagrant up >> log.txt
        k="0"
        while [ "$k" != "1" ]; do
            clear
            echo "Votre machine virtuelle est prête à être utilisée, que voulez vous faire ?"
            echo "1) Vous connecter à la machine virtuelle que vous venez de créer"
            echo "2) Consulter la liste de toutes les machines virtuelles crées sur cet ordinateur"
            echo "3) Vous connecter à une autre machine virtuelle"
            echo "4) Éteindre la machine virtuelle que vous venez de créer"
            echo "5) Éteindre une autre machine virtuelle"
            echo "6) Allumer une machine virtuelle"
            echo "7) Quitter le script"
            read choice_user_action
            if [ "$choice_user_action" = "1" ]; then
                vagrant ssh
            elif [ "$choice_user_action" = "2" ]; then
                clear
                echo -e "\033[33mVoici toutes les machines virtuelles présentes sur votre ordinateur\033[0m"
                vagrant global-status | head -n -6
                read -p "appuyez sur une touche pour continuer" tiemout3
            elif [ "$choice_user_action" = "3" ]; then
                clear
                vagrant global-status | head -n -6
                echo -e "\033[33mPour vous connecter à l'une de ces machines, entrer l'id correspondant situé dans la colonne de gauche ou entrer 'Q' pour annuler\033[0m"
                read id_vagrant
                if [ "$id_vagrant" = "q" ] || [ "$id_vagrant" = "Q" ]; then
                    sleep 0.5
                    echo -e "\033[31mRevenons au menu précedent !\033[0m"
                    sleep 0.5
                else 
                    vagrant ssh $id_vagrant 
                    if [ $? = "1" ]; then
                        clear
                        echo -e "\033[31mil semblerait qu'il y ai eu un problème ...\033[0m"
                        sleep 0.5
                        l="0"
                        while [ "$l" != "1" ]; do
                            echo -e "\033[33mÊtes-vous sur d'avoir tappé le bon id ? O/N\033[0m"
                            read response_id
                            if [ "$response_id" = "O" ] || [ "$response_id" = "o" ]; then
                                while [ "$l" != 1 ]; do
                                    echo -e "\033[32mdans ce cas, c'est que la machine virtuelle n'est pas allumée, voulez vous l'allumer ? O/N\033[0m"
                                    read response_power
                                    if [ "$response_id" = "O" ] || [ "$response_id" = "o" ]; then
                                        sleep 0.5
                                        clear
                                        echo -e "\033[33mLa machine ayant pour id: '$id_vagrant' est entrain de s'allumer !\033[0m"
                                        vagrant up $id_vagrant >> log.txt
                                        clear
                                        m="0"
                                        while [ "$m" != "1" ]; do
                                            echo -e "\033[33mLa machine ayant pour id: '$id_vagrant' est allumée !\033[0m"
                                            echo "voulez-vous vous connecter à celle-ci ? O/N"
                                            read response_power_again
                                            if [ "$response_power_again" = "O" ] || [ "$response_power_again" = "o" ]; then
                                                vagrant ssh $id_vagrant
                                            elif [ "$response_power_again" = "N" ] || [ "$response_power_again" = "n" ]; then
                                                clear
                                            else
                                                echo -e "\033[31mErreur, veuillez choisir entre 'O' ou 'N\033[0m"
                                            fi
                                        done
                                    elif [ "$response_id" = "N" ] || [ "$response_id" = "n" ]; then
                                        l="1"
                                    else
                                        echo -e "\033[31mErreur, veuillez choisir entre 'O' ou 'N'\033[0m"
                                    fi
                                done
                            elif [ "$response_id" = "N" ] || [ "$response_id" = "n" ]; then
                                echo -e "\033[33mC'est surement la cause de cette erreur, revérifions ensemble !\033[0m"
                                read -p "Appuyez sur une touche pour continuer"
                                l="1"
                            else
                                echo -e "\033[31mErreur, veuillez choisir entre 'O' ou 'N'\033[0m"
                            fi
                        done
                    fi
                fi
            elif [ "$choice_user_action" = "4" ]; then
                clear
                echo -e "\033[31mVotre machine est entrain de s'éteindre\033[0m"
                vagrant halt >> log.txt

            elif [ "$choice_user_action" = "5" ]; then
                n="0"
                while [ "$n" != "1" ]; do
                    clear
                    vagrant global-status | head -n -6
                    echo -e "\033[33mPour éteindre l'une de ces machines, entrer l'id correspondant situé dans la colonne de gauche ou entrer 'Q' pour annuler\033[0m"
                    read id_vagrant
                    if [ "$id_vagrant" = "q" ] || [ "$id_vagrant" = "Q" ]; then
                        sleep 0.5
                        echo -e "\033[31mRevenons au menu précedent !\033[0m"
                        sleep 0.5
                        n="1"
                    else
                        clear
                        echo -e "\033[33mLa machine virtuelle est entrain de s'éteindre, veuillez patienter !\033[0m"
                        vagrant halt $id_vagrant >> log.txt
                        if [ $? = 1 ]; then
                            clear
                            echo -e "\033[31mIl y a eu une erreure, votre machine est peut-être déja éteinte, pour plus d'informations allez voir le rapport d'erreur dans log.txt ..\033[0m"
                            read -p "Pressez une touche pour continuer" timeout
                        fi
                    fi
                done
            elif [ "$choice_user_action" = "6" ]; then
                clear
                echo -e "\033[33mVoici toutes les machines virtuelles présentes sur votre ordinateur\033[0m"
                vagrant global-status | head -n -6
                sleep 0.5
                echo "Quelle machine voulez-vous allumer ?"
                read choice_user_id
                sleep 0.5
                clear
                echo -e "\033[33mla machine ayant pour id: '$choice_user_id' est entrain de s'allumer\033[0m"
                vagrant up $choice_user_id >> log.txt
                if [ $? = 1 ]; then
                    echo -e "\033[31mErreur, cette machine n'a pas pu s'allumer, assurez-vous d'avoir tappé le bon id ou que cette machine n'est pas déja allumée et réessayez\033[0m"
                    read -p "Appuyez sur une touche pour continuer" timeoutb
                fi
            elif [ "$choice_user_action" = "7" ]; then
                k="1"
                echo -e "\033[32mÀ bientôt !\033[0m"
            else
                echo -e "\033[31mErreur, veuillez choisir entre '1', '2' ou '3'\033[0m"
                sleep 0.5
            fi
        done 

    elif [ "$response_vm_vbox" = "N" ] || [ "$response_vm_vbox" = "n" ]; then
        j="1"
        echo -e "\033[33mDans ce cas, téléchargez et installez 'Vagrant' + 'Virtual Box' et relancez ce script ensuite\033[0m"
    else
        echo -e "\033[31mErreur, veuillez choisir entre 'O' et 'N'\033[0m"
    fi
done