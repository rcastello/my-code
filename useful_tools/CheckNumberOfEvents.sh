#!/bin/bash
folder=$1
COUNTER=0
for f in $(ls -a ${folder} | grep $2)
do
  echo "Processing $f file..."
  string=`edmEventSize -v -a $folder/$f | grep Events`
  evts=`echo $string | awk '{split($0,a," "); print a[4]}'`
  echo "n. events=" $evts
  let COUNTER=COUNTER+$evts
  echo "total= " $COUNTER
done
echo "grand total= " $COUNTER