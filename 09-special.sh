#!/bin/bash

#how do you get all arguments passed to script 
echo "all arguments passed to script are $@"

#how to get number of arguments passed to script
echo "No.of arguments passed to script : $#"

#how to get script name
echo "name of script is $0"

#how to get current working directory of user
echo "present working directory of user $PWD "

#how to get home directory of user
echo "Home directory of user $HOME"

#Process instance id of executing script
echo "process instance id of executing script $$"

sleep 100 &
#Process instance id of last executed command is 
echo "Process instance id of last executed command $!"