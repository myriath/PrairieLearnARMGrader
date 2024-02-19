#!/bin/bash
VERS=1.2

docker image build . -t prairielearn/armgrader:v$VERS

printf "\nCurrent image tag: prairielearn/armgrader:v$VERS\n"
