#!/bin/sh

if ls forfrealign &>/dev/null; then
mv forfrealign forfrealign_bck
fi

pltfile=$1
num=`wc -l < $pltfile`
for ((i=1; i<=$num; i++))
do
image=`head -$i < $pltfile | tail -1 | awk '{printf("%d", $3)}'`
defvalues=`head -$image < test results | tail -1`
echo $image $defvalues >> forfrealign
done
