#!/bin/bash

# GLOBAL

## CONSTANTS

AIM_ADD="a"
AIM_DELETE="d"
AIM_UPDATE="u"

# MAIN ENTRY POINT

aim=$1
archive=$2

case "$aim" in
  "$AIM_ADD")
  echo Add operation is not implemented
  ;;
  "$AIM_DELETE")
  echo Delete operation is not implemented
  ;;
  "$AIM_UPDATE")
  echo Update operation is not implemented
  ;;
esac

