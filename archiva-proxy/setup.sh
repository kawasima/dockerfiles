#!/bin/bash
set -e

bin/archiva console &

st=0
while [ $st -ne 200 ]
do
    sleep 3
    set +e
    st=$(http_proxy= curl -LI localhost:8080 -o /dev/null -w '%{http_code}' -s)
    set -e
done

if [ $? != 0 ]
then
    echo "Fail to start archiva."
    exit 1
fi

bin/archiva stop
sleep 3

java -cp .:"/apache-archiva/lib/*" AddGuestToObserver /apache-archiva/data/databases/users
