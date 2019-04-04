#!/bin/bash
outputdir=output
mkdir -p $outputdir
yes|w3m -dump "$1" |a2ps -=book -B -q --medium=A4dj --borders=no -o $outputdir/out1.ps 
gs -sDEVICE=png256 -dNOPAUSE -dBATCH -dSAFER -dTextAlphaBits=4 -q -r300x300 -sOutputFile=$outputdir/out2.png $outputdir/out1.ps
prefix="http://["
suffix="]"
filename=`echo $1 |sed -e 's/http\:\/\/\[//' -e 's/\]//'`
convert -trim $outputdir/out2.png $outputdir/$filename.png
rm $outputdir/out1*
rm $outputdir/out2.png

