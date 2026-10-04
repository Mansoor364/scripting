#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"

mkdir -p $LOGS_FOLDER

CHECK_ROOT(){
    USER_ID=$(id -u)
    if [ $USER_ID -ne 0 ]
    then
        echo -e "$R please run the script with root user access $N"        | tee -a $LOG_FILE
        exit 1
    fi
}
CHECK_ROOT

echo -e "Script started executing at :$Y $(date) $N"      | tee -a $LOG_FILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED.. $N"            | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is $G SUCCESS.. $N"           | tee -a $LOG_FILE
    fi
}

dnf install nginx -y                &>>$$LOG_FILE
VALIDATE $? "Installing nginx"

systemctl enable nginx              &>>$$LOG_FILE
VALIDATE $? "Enabling nginx"

systemctl start nginx               &>>$$LOG_FILE
VALIDATE $? "starting nginx"

rm -rf /usr/share/nginx/html/*          &>>$$LOG_FILE
VALIDATE $? "Removing default website"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$$LOG_FILE
VALIDATE $? "downloading frontend code"

cd /usr/share/nginx/html

unzip /tmp/frontend.zip           &>>$$LOG_FILE
VALIDATE $? "Extracting frontend code"

cp /home/ec2-user/scripting/expense.conf /etc/nginx/default.d/expense.conf

systemctl restart nginx            &>>$$LOG_FILE
VALIDATE $? "Re-starting nginx"




