#!/bin/bash
set -eu

echo Setup docker context to dind daemon
docker context create dind --docker=host=tcp://localhost:2375 
docker context use dind

