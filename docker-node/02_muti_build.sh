#!/bin/bash


docker buildx build -t actanble/rhel7 --platform linux/amd64,linux/arm64 . --push