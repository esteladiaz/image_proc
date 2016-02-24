#!/bin/bash

export OMP_NUM_THREADS=30

fin=$1
tif2mrc $fin ${fin/tif/mrc} | tee auxiliar
frames=`tail -2 auciliar | awk '{print $2}' | head -1`

./mag_distortion_correct << EOF
${fin/tif/mrc}
${fin/tif/cor.mrc}
137.3
1
1
yes
gain_ref.mrc
EOF

# mv ${fin/tif/mrc} ${fin/tif/cor.mrc}

label << EOF
${fin/tif/cor.mrc}
4
temp.mrc
2,2,1
EOF
mv temp.mrc ${fin/tif/cor.mrc}

./newunblur << EOF
${fin/tif/cor.mrc}
$frames
${fin/tif/dos.mrc}
${fin/tif/txt}
1.64
YES
5.0
300.0
YES
NO
caca.txt
2.0
200.0
1500
no
3
3
0.1
10
no
no
EOF

ctffind4 << EOF
#${fin/tif/cor.mrc}
yes
7
${fin/tif/dia.mrc}
1.64
300.0
2.7
0.07
512
50
4.5
5000
40000
200
100
no
EOF

echo -e "\n Done with all these files \n"
