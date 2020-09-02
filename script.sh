#!/bin/bash
# build docker sentienel redis for high availablity.
echo -n "Redis HA (start/stop) > "
read text
if [[ "$text" == start ]];then
   docker-compose up --build -d
else
   docker-compose stop
   exit 200
fi
echo 
echo -n "Want To test PUB/SUB MODEL by pausing one Master node (yes/no) > "
read input
if [[ "$input" == yes ]];then
	echo
	while true; do
	    node ./client-redis/client.js
	    echo "------------------------------------+--------------------------------------------"
            echo "MAKE SURE TO PAUSE MASTER BY RUNNING COMMAND IN NEW TERMINAL: docker pause master"
            echo "------------------------------------+--------------------------------------------"
	    sleep 2
	done
else
       echo "exiting..!!!"
       exit 0
fi
