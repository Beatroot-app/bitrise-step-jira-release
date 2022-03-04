#!/bin/bash
set -ex

echo "Installing required deppendencies"
pip install --no-cache-dir requests argparse

echo "Executing jira-release"

./jira-release.py \
    -v ${version_name} \
    -p ${projectId} \
    -u ${user} \
    --password ${password} \
    --update ${update} \
    --released ${released} \
    --archived ${archived} \
    --url ${url}