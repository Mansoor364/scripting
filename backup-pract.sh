#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOUR_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)

USAGE(){
    echo -e "$R USAGE:: $N sh backup-pract.sh sour-dir dest-dir days(optional)"
    exit 1
}

if [ $# -le 2 ]
then
    USAGE
fi

if [ ! -d $SOUR_DIR ]
then
    echo -e "$SOUR_DIR $R is not exist, please check $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$DEST_DIR $R is not exist, Check it $N"
    exit 1
fi

FILES=$(find $SOUR_DIR -name "*.log" -mtime +$DAYS)
echo -e "log files are :$Y $FILES $N"

if [ ! -z $FILES ]
then
    echo -e "$G source files exist $N"
    ZIP_FILE="$DEST_DIR/app-logs-TIME_STAMP.zip"
    find $SOUR_DIR -name "*.log" -mtime +$DAYS | zip $ZIP_FILE -@
    if [ -f $ZIP_FILE ]
    then
        echo -e "zipping log file's is $G successfull $N"
        while IFS= read -r file
        do
            echo "deleting line : $file"
            rm -rf $file
        done <<<$FILES
    else
        echo "Zipping log files older than $DAYS is $R failed $N"
    fi
else
    echo -e "$R log files older than $DAYS not exist $N"
fi

