#!/bin/bash
yggdrasilctl -json -v getDHT|jq '.dht|.[]|[.box_pub_key,.coords]|@csv' |  awk -F "\"*,\"*" '{print "yggdrasilctl getPeers box_pub_key="$1" coords="$2}' |tr -d '\\"' > cords
sed -i '1 i\#!/bin/bash' cords; chmod 755 ./cords
./cords |sort -u 
rm ./cords
