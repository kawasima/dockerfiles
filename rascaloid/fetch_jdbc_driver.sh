#!/bin/bash -u

## requires: curl

declare -A drivers
drivers["h2"]="com.h2database:h2:RELEASE"
drivers["mysql"]="mysql:mysql-connector-java:RELEASE"
drivers["postgres"]="org.postgresql:postgresql:42.2.1"
drivers["sqlserver"]="com.microsoft.sqlserver:mssql-jdbc:6.4.0.jre8"

remote_repository=https://repo.maven.apache.org/maven2

function resolve_version () {
    local version_alias=$1
    local metadata_url=${remote_repository}/$2/maven-metadata.xml
    local xpath="/metadata/versioning/$(echo ${version_alias} | tr 'A-Z' 'a-z')/text()|/metadata/version/text()"

    curl -s ${metadata_url} | xmllint --xpath "$xpath" -
}

function fetch_driver () {
    local dbtype=$1
    local version=$2
    local deps=(`echo ${drivers[$dbtype]} | tr -s ':' ' '`)

    if [ ${#deps[@]} -eq 0 ]; then
        echo "Unknown database type: $dbtype"
        exit 1
    fi

    local group_path=$(echo ${deps[0]} | tr -s '.' '/')
    local artifact_path=${deps[1]}
    if [ -z "${version}" ]; then
        version=${deps[2]}
    fi

    if [ $version = "RELEASE" -o $version = "LATEST" ]; then
        version=$(resolve_version $version "${group_path}/${artifact_path}")
    fi

    local jarfile=${deps[1]}-${version}.jar
    curl -sL -o $dest_dir/$jarfile -w '%{http_code}' \
         ${remote_repository}/${group_path}/${deps[1]}/$version/$jarfile
}

dest_dir=runtime

if [ ! -e "$dest_dir" ]; then
    mkdir -p $dest_dir
fi

for arg in "$@"
do
    dbtypes=(`echo $arg | tr ':' ' '`)
    ret=$(fetch_driver ${dbtypes[0]} ${dbtypes[1]:-""})

    if [ $ret -eq 200 ]; then
        echo "Install driver: ${dbtypes[0]}"
    else
        echo "Not found: ${dbtypes[0]}"
    fi
done
