#!/usr/bin/env bash

set -eo pipefail

LAST_WORKFLOW_RUN_ID=''

if ! WORKFLOW_RUN_ID="$(gh run list -L 1 --json databaseId -q '.[].databaseId')" ; then
  ec=$?
  echo '::error::Failed to probe workflow runs.'
  exit "$ec"
else
  LAST_WORKFLOW_RUN_ID="$WORKFLOW_RUN_ID"
fi

function expect_workflow_conclusion {
  sleep 4
  if ! WORKFLOW_RUN_ID="$(gh run list -L 1 --json databaseId -q '.[].databaseId')" ; then
    ec=$?
    echo '::error::Failed to probe workflow runs.'
    exit "$ec"
  elif [[ -z $WORKFLOW_RUN_ID || $WORKFLOW_RUN_ID == $LAST_WORKFLOW_RUN_ID ]] ; then
    echo '::error::Expected a new workflow run, but no new workflow runs triggered.'
    exit 1
  else
    LAST_WORKFLOW_RUN_ID="$WORKFLOW_RUN_ID"
    echo "Waiting for workflow run $WORKFLOW_RUN_ID to finish..."
    gh run watch "$WORKFLOW_RUN_ID" -i 1 > /dev/null
    if ! WORKFLOW_CONCLUSION="$(gh run view "$WORKFLOW_RUN_ID" --json conclusion -q .conclusion)" ; then
      ec=$?
      echo '::error::Failed to retrieve conclusion for the workflow run.'
      exit "$ec"
    elif [[ $WORKFLOW_CONCLUSION != $1 ]] ; then
      echo "::error::Expected the workflow run's conclusion to be \"$1\", but it was instead \"$WORKFLOW_CONCLUSION\"."
      exit 1
    fi
  fi
}



# Setup
git config core.autocrlf false



echo '::group::Expect a successful workflow run after pushing an LF file'

echo > lf.txt
git add . && git commit -m LF
git push
expect_workflow_conclusion success

echo '::endgroup::'



echo '::group::Expect a failed workflow run after pushing an CRLF file'

echo $'\r' > crlf.txt
git add . && git commit -m CRLF
git push
expect_workflow_conclusion failure

echo '::endgroup::'



echo '::group::Expect a successful workflow run after correcting the CRLF file'

echo > crlf.txt
git add . && git commit -m 'Fix CRLF'
git push
expect_workflow_conclusion success

echo '::endgroup::'



echo '::group::Expect a failed workflow run after pushing a file with mixed line endings'

echo $'\n\r' > mixed.txt
git add . && git commit -m 'mixed'
git push
expect_workflow_conclusion failure

echo '::endgroup::'



echo '::group::Expect a successful workflow run after correcting the file with mixed line endings'

echo > mixed.txt
git add . && git commit -m 'Fix mixed'
git push
expect_workflow_conclusion success

echo '::endgroup::'



echo '::group::Expect a successful workflow run after pushing a binary file'

tar -czf binary.tar.gz *.txt
git add . && git commit -m 'binary'
git push
expect_workflow_conclusion success

echo '::endgroup::'
