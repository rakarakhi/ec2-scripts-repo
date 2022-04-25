#https://linuxhint.com/bash_wait_keypress/

#!/bin/bash
echo "Press any key to continue"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
exit ;
else
echo "waiting for the keypress"
fi
done


#!/bin/bash
echo "Press 'q' to exit"
count=0
while : ; do
read -n 1 k <&1
if [[ $k = q ]] ; then
printf "\nQuitting from the program\n"
break
else
((count=$count+1))
printf "\nIterate for $count times\n"
echo "Press 'q' to exit"
fi
done




#!/bin/bash
v1=$1
v2=$2
while :
do
echo "1. Addition"
echo "2. Subtraction"
echo "3. Quit"
echo -n "Type 1 or 2 or 3 :"
read -n 1 -t 15 a
printf "\n"
case $a in
1* )     echo "$v1 + $v2 = $(($v1+$v2))";;
 
2* )     echo "$v1 - $v2 = $(($v1-$v2))";;
 
3* )     exit 0;;

 
* )     echo "Try again.";;
esac
done




#!/bin/bash
userinput=""
echo "Press ESC key to quit"
# read a single character
while read -r -n1 key
do
# if input == ESC key
if [[ $key == $'\e' ]];
then
break;
fi
# Add the key to the variable which is pressed by the user.
userinput+=$key
done
printf "\nYou have typed : $userinput\n"




#!/bin/bash
echo "Enter the server address that you want to ping"
read server
while ! ping -c 1 -n -W 2 $server
do
echo "Trying to connect with $server"
echo "Press [ENTER] to terminate"
read -s -N 1 -t 1 key
if [[ $key == $'\x0a' ]];        # if input == ENTER key
then
exit 0
fi
done
printf "%s\n" "$server is running"