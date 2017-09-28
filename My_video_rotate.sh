#!/bin/bash

USAGE="*** USAGE: $0 -o FILE-OUT FILE-IN  (FILE-OUT) is optional"
while test $# -gt 0; do
  case "$1" in

    -help|--help|-h) echo "$USAGE"; exit 0;;
    -o)  shift; FILE_OUT="$1";;
    -o*) FILE_OUT="`echo :$1 | sed 's/^:-o//'`";;
    *)   FILE_IN="$1";;
  esac
  shift
done


if [ "$FILE_IN" = "" ] ; then
   echo "$USAGE"; exit 0
fi

if [ "$FILE_OUT" = "" ] ; then
  FILE_OUT="${FILE_IN%.*}_rotated.${FILE_IN#*.}"
fi


echo "*** Note: Rotating to $FILE_OUT"

time ffmpeg -i $FILE_IN -vf "transpose=2,transpose=2" -c:a copy -c:s copy $FILE_OUT
