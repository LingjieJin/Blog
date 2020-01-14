#!/bin/bash

# var
process_name="cv_detecter_main"
process_path=/home/cv/cv_detecter/cv_detecter_main
process_log=/home/cv/cv_detecter/log.txt

#
echo "now start cv detecter"

# define check function
fun(){
	# start sleep
	sleep 1m

	# check capture online
	while [ true ]
	do
		ping 192.168.10.30 -c 1
		if [ $? -eq 0 ]
		then
			break
		fi
		echo "capture not online"
		sleep 2m
	done

	# circle checking
	while [ true ]
	do
		ps -ef | grep ${process_name} | grep -v grep
		if [ $? -ne 0 ]
		then
			echo "not exist, create process"
			($process_path) &
			pid=$(ps -ef | grep ${process_name} | grep -v grep | awk '{print $2}')
			date=$(date "+%Y-%m-%d %H:%M:%S")
			echo "${date} ${process_name} PID=${pid} start." >> ${process_log}
		else
			echo "exist, ignore"
		fi
		# circle search
		sleep 1m #sleep 1 minute
	done
}

# only run this function
fun

# error quit
echo "error quit!" >> ${process_log}
