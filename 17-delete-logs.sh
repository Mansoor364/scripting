#!/bin/bash
R="\e[31m"
G="\[32m"
Y="\[33m"
N="\[0m"

SOUR_DIR="/home/ec2-user/log"    #ask source directory where log files are present

if [ -d $SOUR_DIR ]
then
    echo -e "$SOUR_DIR is $G exist $N"
else
    echo -e "$SOUR_DIR $R doesn't exist $N"
fi

FILES=$(find $SOUR_DIR -name "*.log" -mtime +14)
echo -e "log files older than 14 days are :$Y $FILES $N"

while IFS= read -r file
do
    echo -e " $Y deleting line :$N  $file"
    rm -rf $file
done <<< $FILES

