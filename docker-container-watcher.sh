#!/bin/bash

# CRONJOB for checking the xxx docker container.
#
# Needs docker container as argument.
#
# test me like so:
# while true; do ./docker-container-watcher.sh "xxx:latest"; sleep 5; done
#
# Graylog:
# <http://graylog.example.com:9000/search?rangetype=relative&fields=message%2Csource&width=1667&highlightMessage=&relative=300&q=type%3Ddocker-watcher>
#

CONTAINER=$1
if [ "x$CONTAINER" == "x" ]; then
	echo "need argument what container to watch (name of docker-container, see docker ps -a,  e.g. \"xxx:latest\" )"
	exit 1
fi


DATE=`date '+%Y-%m-%d %H:%M:%S'`
HOSTNAME=`hostname`
HOSTCONTI="$HOSTNAME::$CONTAINER"
RESULT=`docker inspect --format='{{json .State.Health.Status}}' $CONTAINER 2>&1`
RESULT=`echo $RESULT | tr -d '\n' | tr -d '\"'`
MESSAGE="$DATE - $HOSTCONTI - $RESULT"


echo $MESSAGE
echo "{ \"version\": \"0.1\", \"message\": \"status=$RESULT\", \"type\": \"docker-watcher\" , \"host\": \"$HOSTCONTI\" }" | gzip | nc -u -w 1 graylog.example.com 12201


if [ "$RESULT" == "healthy" ]; then
	echo -n ""
	#echo "$DATE - >>>>>> status healthy, nothing to do"
elif [ "$RESULT" == "starting" ]; then
	echo -n ""
	#echo "$DATE - >>>>>> status starting, nothing to do."
elif [ "$RESULT" == "unhealthy" ]; then
	echo "$DATE - $CONTAINER - >>>>>> container in bad state, stop and start now."
	DATE=`date '+%Y-%m-%d %H:%M:%S'`
	echo -n "$DATE - $CONTAINER - >>>>>> [docker stop $CONTAINER]: "
	docker stop $CONTAINER
	DATE=`date '+%Y-%m-%d %H:%M:%S'`
	echo -n "$DATE - $CONTAINER - >>>>>> [docker start $CONTAINER]: "
	docker start $CONTAINER
else
	# echo -n ""
	echo "$DATE - $CONTAINER - >>>>>> specified container not found. exiting."
	RESULT='unknown'
fi


#EOF
