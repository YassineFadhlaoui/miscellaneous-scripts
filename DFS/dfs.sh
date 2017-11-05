#!/bin/bash

declare -a STACK
declare -i lastindex
lastindex=-1
tmp_dir=$PWD

function stack()
{
echo "==> treating $tmp_dir"
cd $tmp_dir
lastindex=$lastindex+1
STACK[$lastindex]=$PWD
echo "	--> The stack now contains ${STACK[*]}"
loop_through

}

function unstack()
{
 echo "	 --> cannot go further! unstacking ${STACK[$lastindex]}"
 unset STACK[$lastindex]
 lastindex=$lastindex-1
 if [[ $lastindex -gt -1 ]]
 then
	cd ${STACK[$lastindex]}
 else
	echo "done"
 fi
}

function loop_through()
{
 if [[ -z "$(ls)" ]]
 then
    unstack

 else
    for i in $(dir)
    do

      tmp_dir=$i
      if test -d $i
      then
      stack
      fi
    done
    unstack
 fi

}

stack
echo ${STACK[*]}
#unset STACK
