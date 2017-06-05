#!/bin/sh
if [ "${PROJECT_DIR}X" != "X" ]; then
    echo "${GIT_REPO}" > ${PROJECT_DIR}/git.txt
else 
    echo "No environment set" > /tmp/git.txt
fi

${PROJECT_DIR}/tests.sh
${PROJECT_DIR}/git_clone.sh
sleep 300
