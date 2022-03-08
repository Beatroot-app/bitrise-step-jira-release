#!/bin/bash
set -ex

echo "Installing required deppendencies"
pip install --no-cache-dir requests argparse

echo "Executing jira-release"

COMMAND=$(cat << EOF
./jira-release.py \
    -v ${version_name} \
    -p ${projectId} \
    -u ${user} \
    --password ${password} \
    --update ${update} \
    --url ${url}
EOF
)

if [ ! -z "${new_version}" -a "${new_version}" != " " ]; then
    COMMAND="$COMMAND --new-version ${new_version}"
fi

if [ ! -z "${description}" -a "${description}" != " " ]; then
    COMMAND="$COMMAND --description ${description}"
fi

if [ "${released}" != "Ignore" ] && [ ! -z "${new_version}" -a "${new_version}" != " " ]; then
    COMMAND="$COMMAND --released ${released}"
fi

if [ "${archived}" != "Ignore" ] && [ ! -z "${new_version}" -a "${new_version}" != " " ]; then
    COMMAND="$COMMAND --archived ${archived}"
fi