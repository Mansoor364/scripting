#!/bin/bash
num=$1
echo "please enter a number"
if [ $num -ge 25 ]
then
    echo "entered number $num is greater than/equal to 25"
else
    echo "entered number $num is less than 25"
fi
