#!/bin/bash

minGames=200

maxPower=`sqlite3 database.db "select max(((SLG-AVG)*1000)/3) from Batting where yearId='$1' and AB > $minGames;"`
scalingPower=`bc <<< "scale=4; 100/$maxPower"`

speedCalculation="(\"3B\" + \"SB\"*2)"
maxSpeed=`sqlite3 database.db "select max($speedCalculation) from Batting where yearId='$1' and AB > $minGames;"`
scalingSpeed=`bc <<< "scale=4; 100/$maxSpeed"`

echo "Max Power from $1 is $maxPower and scaling is $scalingPower"
echo "Max Speed from $1 is $maxSpeed and scaling is $scalingSpeed"

sqlite3 -header -column database.db "select nameFirst, nameLast, cast(((SLG-AVG)*1000)/3*$scalingPower as integer) as Power, cast($speedCalculation*$scalingSpeed as integer) as Speed from Batting left join People on "Batting".playerId = "People".playerId where teamId='$2' and yearId='$1' and AB > 0 order by Power asc;"

#f1_speed="(20 * (((SB + 3)/(SB + CS + 7)) - 0.4))"
