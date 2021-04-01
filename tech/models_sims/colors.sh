#!/bin/bash

for i in 1-1 1-2 1-3 1-4 2-1 2-2 2-3 2-4 3-1 3-2 3-3 3-4; do echo $i; cols=$(tail -1 ../wifi_maps/netlogo_colors/TownTechMap_${i}.txt); new=$(echo "["$cols"]"); echo $new; sed -i.bak '/\[7/c\'"${new}" town_wifi_map${i}.nlogo; done
