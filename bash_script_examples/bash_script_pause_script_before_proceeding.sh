#!/bin/bash
#Reference: https://linuxconfig.org/bash-script-pause-script-before-proceeding
#
##Step - 1
##########
##Let’s start with a basic example of the sleep command. This is easy to use, and allows us to pause our Bash script for any amount of time in seconds, minutes, hours, or even days.
#!/bin/bash
#
	echo "Script will proceed in 5 seconds..."
#
	sleep 5s
#
	echo "Thanks for waiting."
##Obviously this script does not have much practicality, but you can see how the sleep command works. You can also use decimals with sleep and other units of time as mentioned above. Note you do not need to include the s for seconds, it is optional.
#
#
sleep 10 # pauses for 10 seconds
sleep 5.5 # pauses for 5.5 seconds
sleep 10m # pauses for 10 minutes
sleep 3h # pauses for 3 hours
sleep 3.5h # pauses for 3 hours, 30 minutes
sleep 2d # pauses for 2 days
##
##
##Step - 2
##########
#
#The example above shows us how the sleep command works, but how would it be useful in a real Bash script? Pausing a script proves very useful in loops, specifically. Loops tend to execute very quickly at times, and can overwhelm your system’s resources if you do not employ a sleep command or similar to force the loop to take a break.
#
#!/bin/bash

var=0

while [ $var -lt 4 ]
do
	ssh user@10.0.0.1
	sleep 1m
	((var++))
done
#
#The script above will continuously try to establish an SSH connection with a host, up to five times. This is a nice way to try and get a connection to a computer which is in the process of coming online, and you do not want to keep entering the SSH command yourself. The sleep command in our script prevents the while loop from spamming the ssh command, by forcing it to pause for one minute. This is just one example of how pausing your script with the sleep command can be very handy.
##
##Step - 3
##########
#
#We can also use the read command to pause our Bash script. Use the -t command and the number of seconds to pause the script. We are also including the -p option and some informative text in this example, but it is not strictly necessary.
#
#!/bin/bash

read -p "Pausing for 5 seconds" -t 5

echo "Thanks for waiting."
#
#This method is nice because, to skip the timer, you can simply press Enter on your keyboard to force the timer to expire and have the script proceed. Returning to our SSH script in the previous example, imagine if we had used the read command instead of sleep, so that we could force a new SSH attempt if we got impatient for the while loop to be triggered again.
#
#
##
##Step - 4
##########
#
##Since the read command is normally used to read input from the command line, the -t option allows us to make our user prompt expire after a certain time. Let’s look at a practical example.
#
#!/bin/bash

read -p "Do you want to proceed? (yes/no) " -t 10 yn

if [ -z "$yn" ]
then
      echo -e "\nerror: no response detected"
      exit 1
fi

case $yn in 
	yes ) echo ok, we will proceed;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac

echo doing stuff...
#
#The script above is a simple yes or no prompt. These are very common throughout Linux and Bash scripts, which usually ask a user if they would like to proceed with something. In the script above, our -t 10 option in the read command will make the script proceed after 10 seconds, unless the user enters a response before then. Our if statement is triggered if an empty response is detected, and will issue an error and exit. If a response is detected, then the case statement is triggered.













