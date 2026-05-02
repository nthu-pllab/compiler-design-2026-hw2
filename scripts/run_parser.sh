#!/bin/bash
set -e

docker compose run --rm -T hw2 run_parser "$@"
