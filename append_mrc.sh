#!/bin/bash

# appends multiple single-location MRC files to one large MRC stack.
# check there are only two arguments.

if [ $# -ne 2 ]
then
	echo "Usage: `basename $0` '{input_filename_pattern}' {output_stack_filename}"
	echo ""
	echo "Make sure the input file name is surrounded by"
	echo "single quotations so that the shell doesn't"
	echo "expand on it before passing the arguments to the script"
	echo ""
	exit -1
fi

input_fns=$1
output_fns=$2

# count num. of input files
i = 0
for token in ${input_fns}; do i=$((i+1)); done
number_of_input_files=$i
echo "Number of input files to be concatenated: ${number_of_input_files}"

# prepare list file for new stack
list_fn=token
echo $number_of_input_files > $list_fn
for input_fn in ${input_fns}
do
	echo $input_fn >> $list_fn
	# get num. of slices -1
	last_loc=$(header $input_rn | awk '/sections/ {print $9-1}')
	echo "0-$last_loc" >> $list_fn
done

newstack -fileinlist $list_fn -output $output_fn

rm -f $list_fn

