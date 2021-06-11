#!/usr/bin/env bash
##
## Run available goss tests.
##

BASEDIR=$(dirname "$0")
fails=0

for file in $BASEDIR/goss.*.yaml; do
  prefix=$BASEDIR/goss.
  service=${file/$prefix/}
  service=${service/.yaml/}

  echo "==> Running tests for $service..."
  cp $file $PWD/goss.yaml
  if ! dgoss run -i bay/$service:latest; then
    fails=$((fails + 1))
  fi
  rm $PWD/goss.yaml
done

exit $fails
