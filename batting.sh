#!/bin/bash

minGames=200

maxPower=`sqlite3 database.db "select max(((SLG-AVG)*1000)/3) from Batting where yearId='$1' and AB > $minGames;"`
scalingPower=`bc <<< "scale=4; 100/$maxPower"`

echo "Max Power from $1 is $maxPower and scaling is $scalingPower"

load_extension="select load_extension(\"./libsqlitefunctions\");"
f1_speed="(20.0 * (((SB + 3.0)/(SB + CS + 7.0)) - 0.4))"
f2_speed="((1/0.07) * sqrt((SB + CS + 0.0)/(\"1B\" + BB + HBP + 0.0)))"
f3_speed="(625 * ((\"3B\") / (AB + HR + SO + 0.0)))"
f4_speed="(25.0 * (((R-HR+0.0)/(H+BB+HBP-HR+0.0)) - 0.1))"
f5_speed="((1/0.007) * (0.063 - (GIDP/(AB-HR-SO+0.0))))"
f6_speed="TODO"
final_speed_calculation="($f1_speed + $f2_speed + $f3_speed + $f4_speed + $f5_speed) / 5"

#sqlite3 -header -column database.db "$load_extension select nameFirst, nameLast, cast(((SLG-AVG)*1000)/3*$scalingPower as integer) as Power, round($final_speed_calculation * 10) as Speed from Batting left join People on "Batting".playerId = "People".playerId where teamId='$2' and yearId='$1' and AB > 100 order by Speed asc;"

sqlite3 -header -column database.db "select nameFirst, nameLast, cast(((SLG-AVG)*1000)/3*$scalingPower as integer) as Power from Batting left join People on "Batting".playerId = "People".playerId where teamId='$2' and yearId='$1' and AB > 100 order by Power asc;"
