#!/bin/bash

set -e #setting automatic exit when script fails

failure(){
    echo "failed at $1:$2 "
}
trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR

echo "Hello world Success!!"
echooo "Hello world  -Failed"
echo "Hello world -After failing"


