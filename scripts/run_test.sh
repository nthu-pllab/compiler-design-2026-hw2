#!/bin/bash
set -e

docker compose run --rm hw2 run_test "$@"
