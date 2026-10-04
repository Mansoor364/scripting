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
    echo -e "$R sh 18-backup.sh sour-dir dest-dir days(optional) $N"
}

if [ $# -lt 2 ]
then
    USAGE
    exit 1
fi

if [ ! -d $SOUR_DIR ]
then
    echo -e "$SOUR_DIR $R doesn't exist..$N please provide a directory"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e  "$DEST_DIR $R doesn't exist, $N please provide a dest directory"
    exit 1
fi

FILES=$(find $SOUR_DIR -name "*.log" -mtime +$DAYS)
echo -e "log files are :$Y $FILES $N "

if [ ! -z $FILES ]
then
    echo -e "Source files $G exist $N"
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"
    find $SOUR_DIR -name "*.log" -mtime +$DAYS | zip $ZIP_FILE -@
    if [ -f $ZIP_FILE ]
    then
        echo -e "Zipping is $G Sucessfull $N"
        while IFS= read -r file
        do
            echo -e "$Y deleting line $N : $file"
            rm -rf $file
        done <<<$FILES
    else
        echo -e "Zipping log file older than $DAYS is $R failed $N"
    fi 
else
    echo -e "source files older than $DAYS $R not exist $N"
fi



