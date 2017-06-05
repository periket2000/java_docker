#!/bin/sh

echo "... cloning ${GIT_REPO} ..."
cd ${PROJECT_DIR}
git -c http.sslVerify=false clone ${GIT_REPO}
GIT_DIR=$(echo ${GIT_REPO##*/} | cut -d. -f1)
cd ${GIT_DIR}/${SRC_DIR}

if [ "x${BUILD_SOURCES}" == "xtrue" ]; then
    echo "... building application ..."
    mvn clean package
fi

echo "... running application ..."
java -jar ./${APP_FILE}
