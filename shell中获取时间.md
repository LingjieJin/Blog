# linux shell中获取时间

```
#!/bin/bash

#明天凌晨 对应的毫秒时间戳
tomorrow=`date -d next-day +%Y-%m-%d`
timeStamp=`date -d "$tomorrow 00:00:00" +%s`
currentTimeStamp=$(($timeStamp*1000+`date "+%N"`/1000000))
#将current转换为时间戳，精确到毫秒
echo $currentTimeStamp
#当前时间对应的毫秒时间戳<
current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
currentTimeStamp=$((timeStamp*1000+`date "+%N"`/1000000))
#将current转换为时间戳，精确到毫秒
echo $curre
```

# 简单的开机检测脚本
```
#!/bin/bash

# var
process_name="mqtt_logger_main"
process_path=/home/cv/mqtt_logger/mqtt_logger_main
process_log=/home/cv/mqtt_logger/log.txt

# check function
fun(){
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
                sleep 1m #sleep 1 minute
        done
}

# only run
fun

# error quit
echo "error quit!" >> ${process_log}
```
