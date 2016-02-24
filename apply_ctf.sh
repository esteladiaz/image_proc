#!/bin/bash

export OMP_NUM_THREADS = 16
fin=$1
./apply_ctf << EOF
$fin
${fin/doss.mrc/ctf.mrc}
0.97		#pixel size for vsva .tifs
EOF
