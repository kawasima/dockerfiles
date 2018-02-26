#!/bin/bash
set -e

DATA_DIR=${DATA_DIR:=/apache-archiva/data}

function urlParse(){
    # extract the protocol
    local proto="$(echo $1 | grep :// | sed -e's,^\(.*://\).*,\1,g')"

    # remove the protocol -- updated
    url=$(echo $1 | sed -e s,$proto,,g)

    # extract the user (if any)
    user="$(echo $url | grep @ | cut -d@ -f1)"

    # extract the host -- updated
    host=$(echo $url | sed -e s,$user@,,g | cut -d/ -f1)

    # by request - try to extract the port
    port="$(echo $host | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"

    host=${host/:$port}
    echo "$host $port"
}

hostAndPort=(`urlParse ${http_proxy}`)
proxyId=""
remoteDownloadNetworkProxyId=""
networkProxy=""

if [ ${#hostAndPort[@]} -ge 1 ]
then
    remoteDownloadNetworkProxyId='<remoteDownloadNetworkProxyId\>proxy<\/remoteDownloadNetworkProxyId>'
    proxyId='<proxyId>proxy<\/proxyId>'
    networkProxy=" \
      <networkProxy> \
          <id>proxy<\/id> \
          <protocol>https<\/protocol> \
          <host>${hostAndPort[0]}<\/host> \
          <port>${hostAndPort[1]}<\/port> \
          <username\/> \
          <password\/> \
          <useNtml>false<\/useNtml> \
      <\/networkProxy>"

fi

cat ${DATA_DIR}/archiva.xml | \
    sed "s/{{remoteDownloadNetworkProxyId}}/${remoteDownloadNetworkProxyId}/g" | \
    sed "s/{{proxyId}}/${proxyId}/g" | \
    sed "s/{{networkProxy}}/${networkProxy}/g" > /tmp/archiva.xml

mv /tmp/archiva.xml ${DATA_DIR}/archiva.xml
