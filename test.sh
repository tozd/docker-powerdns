#!/bin/sh

set -e

cleanup() {
  set +e

  echo "Logs"
  docker logs test

  echo "Stopping Docker image"
  docker stop test
  docker rm -f test
}

echo "Running Docker image"
docker run -d --name test -e LOG_TO_STDOUT=1 -p 53:53/tcp -p 53:53/udp "${CI_REGISTRY_IMAGE}:${TAG}"
trap cleanup EXIT

echo "Sleeping"
sleep 10

echo "Testing"
nc -z docker 53
echo "Success"

echo "Testing"
! nslookup -type=any example.com docker | grep "no servers could be reached"
echo "Success"
