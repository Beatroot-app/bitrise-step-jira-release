#!/bin/bash
set -ex

echo "Installing required deppendencies"
pip3 install --no-cache-dir requests argparse

echo "Executing jira-release"

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

COMMAND=$(cat << EOF
python3 $THIS_SCRIPT_DIR/jira-release.py \
    -v ${version_name} \
    -p ${projectId} \
    -u ${user} \
    --password ${password} \
    --url ${url}
EOF
)

if [ "${update}" == "true" ] && [ ! -z "${update}" -a "${update}" != " " ]; then
    COMMAND="$COMMAND --update ${update}"
fi

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

eval $COMMAND