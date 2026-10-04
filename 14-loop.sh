#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

ROOT_CHECK(){
    USER_ID=$(id -u)
    if [ $USER_ID -ne 0 ]
    then
        echo -e "please run the script with $R root user access $N"
        exit 1
    fi
}
ROOT_CHECK()

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED..$N"
        exit 1
    else
        echo -e "$2 is $G SUCCESS..$N"
    fi
}

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        echo -e "$package is not installed.. $Y going to install it $N"
        dnf install $package -y
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is $G already installed $N  nothing to do.."
    fi
done 