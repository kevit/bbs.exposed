#!/bin/bash
arceliar=`curl http://[21f:dd73:7cdb:773b:a924:7ec0:800b:221e]/static/graph.json| ./filters/extract_ipv6.sh|sort -u`
yakamo=`curl http://[301:4541:2f84:1188:216:3eff:feb6:65a3]:3000/current | ./filters/extract_ipv6.sh|sort -u`
wc -l <<< "$arceliar"
wc -l <<< "$yakamo"
#comm -12  <(echo $arceliar) <(echo $yakamo)
comm -3 <(echo "$arceliar") <(echo "$yakamo")
#diff -ia --suppress-common-lines <(echo "$arceliar") <(echo "$yakamo")
