#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

ROOT_CHECK(){
    USER_ID=$(id -u)
    if [ $USER_ID -ne 0 ]
    then
        echo -e "Please run script with $R root user privileges $N"
        exit 1
    fi
}
ROOT_CHECK

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED..$N"
        exit 1
    else
        echo -e "$2 is $G SUCCESS..$N"
    fi
}

dnf list installed git
if [ $? -ne 0 ]
then
    echo -e "git is not installed..$Y going to install it$N"
    dnf install git -y
    VALIDATE $? "Installing git"
else
    echo -e "git is $G already installed..nothing to do $N"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo -e  "mysql is $Y not installed going to install it$N"
    dnf install mysql -y
    VALIDATE $? "Installing mysql"
else
    echo -e "Mysql is $G already installed $N nothing to do"
fi

