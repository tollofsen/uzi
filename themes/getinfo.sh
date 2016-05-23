#!/bin/sh
THEMES=$(ls *.th)
echo Themes: $THEMES
  THFILE=$(echo $THEMES | awk '{print $1}')
  cat $THFILE | grep /let
  $THEMES=$(eval echo $THEMES | sed s/$THFILE\ //1)
  $THEMES=$(eval echo $THEMES | sed s/$THFILE//1)
echo $THEMES
exit 0
