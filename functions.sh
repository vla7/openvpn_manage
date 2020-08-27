#!/bin/bash

function error() {
echo "ERROR: $*" | tee -a ${0}.log
}
function log() {
echo "$*" | tee -a ${0}.log
}

