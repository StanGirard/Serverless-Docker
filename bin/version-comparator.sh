#!/bin/bash
if [[ -z $1 ]]; then
    echo "Error: undefined Github repository"
    exit 1
fi

vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

RELEASE=`cat VERSION`
NEW_VERSION=`git ls-remote --tags "$1" | cut -d/ -f3- | tail -n1 | cut -c2-;`
echo $RELEASE
vercomp $RELEASE $NEW_VERSION
if [[ $? -eq 2 ]]; then
    printf $NEW_VERSION > VERSION
    exit 0
else
    echo nothing
    exit 1
fi
