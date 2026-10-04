#!/bin/bash
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]
then
    echo "please run the script with root user access"
    exit 1
fi

dnf list installed git
if [ $? -ne 0 ]
then
    echo "git is not installed, going to install it"
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "git installation failed.. check it"
        exit 1
    else
        echo "git installation is SUCCESS"
    fi
else
    echo "git is already installed, nothing to do "
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed, going to install it"
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "mysql installation failed..check it"
        exit 1
    else
        echo "mysql is installed successfully"
    fi
else
    echo "mysql is already installed,nothing to do"
fi
