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
echo "Repository: $1"
NEW_VERSION=`curl --silent "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'| cut -c2-;`
echo "Release ${RELEASE}"
echo "New Version ${NEW_VERSION}"
vercomp $RELEASE $NEW_VERSION
if [[ $? -eq 2 ]]; then
    printf $NEW_VERSION > VERSION
else
    echo nothing
fi
