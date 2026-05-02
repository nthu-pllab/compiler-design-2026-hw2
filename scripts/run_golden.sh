#!/bin/bash
set -e

docker compose run --rm -T hw2 golden_parser "$@"
