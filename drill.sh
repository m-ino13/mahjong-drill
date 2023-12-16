#!/bin/bash

function rd() {
  read input
  input=${input:0:1}
  if [ "${input}" = "q" -o "${input}" = "Q" ]; then exit; fi
}

# x符y翻の点数は，y<=4で ${scores_le4[$((X*4+y-1))]} , y>4で ${scores_gt4[$((y-5))]}
# x: 20, 25, 30, 40, 50, 60, 70, 80, 90
# X:  0,  1,  2,  3,  4,  5,  6,  7,  8
index2fu=(20 25 30 40 50 60 70 80 90)

# 20fu=(NA 400-700,700all 700-1300,1300all 1300-2600,2600all)
# 25fu=(NA 1600ron,2400ron 3200ron-800-1600,4800ron-1600all 6400ron-1600-3200,9600ron-3200all)
# 30fu=(1000ron-300-500,1500ron-500all 2000ron-500-1000,2900ron-1000all 3900ron-1000-2000,5800ron-2000all 7700ron-2000-3900,11600ron-3900all)
# 40fu=(1300ron-400-700,2000ron-700all 2600ron-700-1300,3900ron-1300all 5200ron-1300-2600,7700ron-2600all 8000ron-2000-4000,12000ron-4000all)
# 50fu=(1600ron-400-800,2400ron-800all 3200ron-800-1600,4800ron-1600all 6400ron-1600-3200,9600ron-3200all 8000ron-2000-4000,12000ron-4000all)
# 60fu=(2000ron-500-1000,2900ron-1000all 3900ron-1000-2000,5800ron-2000all 7700ron-2000-3900,11600ron-3900all 8000ron-2000-4000,12000ron-4000all)
# 70fu=(2300ron-600-1200,3400ron-1200all 4500ron-1200-2300,6800ron-2300all 8000ron-2000-4000,12000ron-4000all 8000ron-2000-4000,12000ron-4000all)
# 80fu=(2600ron-700-1300,3900ron-1300all 5200ron-1300-2600,7700ron-2600all 8000ron-2000-4000,12000ron-4000all 8000ron-2000-4000,12000ron-4000all)
# 90fu=(2900ron-800-1500,4400ron-1500all 5800ron-1500-2900,8700ron-2900all 8000ron-2000-4000,12000ron-4000all 8000ron-2000-4000,12000ron-4000all)

scores_le4=(NA 400-700,700all 700-1300,1300all 1300-2600,2600all NA 1600ron,2400ron 3200ron-800-1600,4800ron-1600all 6400ron-1600-3200,9600ron-3200all 1000ron-300-500,1500ron-500all 2000ron-500-1000,2900ron-1000all 3900ron-1000-2000,5800ron-2000all 7700ron-2000-3900,11600ron-3900all 1300ron-400-700,2000ron-700all 2600ron-700-1300,3900ron-1300all 5200ron-1300-2600,7700ron-2600all 8000ron-2000-4000,12000ron-4000all 1600ron-400-800,2400ron-800all 3200ron-800-1600,4800ron-1600all 6400ron-1600-3200,9600ron-3200all 8000ron-2000-4000,12000ron-4000all 2000ron-500-1000,2900ron-1000all 3900ron-1000-2000,5800ron-2000all 7700ron-2000-3900,11600ron-3900all 8000ron-2000-4000,12000ron-4000all 2300ron-600-1200,3400ron-1200all 4500ron-1200-2300,6800ron-2300all 8000ron-2000-4000,12000ron-4000all 8000ron-2000-4000,12000ron-4000all 2600ron-700-1300,3900ron-1300all 5200ron-1300-2600,7700ron-2600all 8000ron-2000-4000,12000ron-4000all 8000ron-2000-4000,12000ron-4000all 2900ron-800-1500,4400ron-1500all 5800ron-1500-2900,8700ron-2900all 8000ron-2000-4000,12000ron-4000all 8000ron-2000-4000,12000ron-4000all)
scores_gt4=(8000ron-2000-4000,12000ron-4000all 12000ron-3000-6000,18000ron-6000all 12000ron-3000-6000,18000ron-6000all 16000ron-4000-8000,24000ron-8000all 16000ron-4000-8000,24000ron-8000all 16000ron-4000-8000,24000ron-8000all 24000ron-6000-12000,36000ron-12000all 24000ron-6000-12000,36000ron-12000all 32000ron-8000-16000,48000ron-16000all 32000ron-8000-16000,48000ron-16000all)

wind=(東 北 西 南)
i=$(($RANDOM % 4))

echo; echo "  === MAHJONG SCORE DRILL ==="; echo
echo "press [Enter] to proceed to next"
echo "input [Q] or press [Ctrl-C] to quit"; echo

while true; do
  hon=$(shuf -e 0 0 0 0 1 1 1 2 2 3 -n 1)
  han=$(shuf -e 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 4 4 4 4 5 6 7 8 9 10 11 12 13 14 -n 1)
  fuindex=$(shuf -e 0 0 0 0 0 0 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 5 5 6 6 7 8 -n 1)
  fu=${index2fu[${fuindex}]}

  if [ ${han} -le 4 ]; then
    score=${scores_le4[$((${fuindex}*4+${han}-1))]}
  else
    score=${scores_gt4[$((${han}-5))]}
  fi

  if [ ${score} = "NA" ]; then continue; fi

  echo "Q: ${hon}本場 ${wind[${i}]}家 ${han}翻 ${fu}符"
  rd

  echo "A:"

  if [ ${i} -eq 0 ]; then # 親
    score=$(echo ${score} | sed -e "s/.*,//g")
    ron=$(echo ${score} | grep -o ".*ron" | sed -e "s/ron//")
    if [ -n "${ron}" ]; then ron=$(echo "${ron}+300*${hon}"|bc); echo "  ron: ${ron}"; fi
    tsumo=$(echo ${score} | grep -o "[0-9]*all" | sed -e "s/all//")
    if [ -n "${tsumo}" ]; then tsumo=$(echo "${tsumo}+100*${hon}"|bc); echo "  tsumo: ${tsumo}all"; fi
  else # 子
    score=$(echo ${score} | sed -e "s/,.*//g")
    ron=$(echo ${score} | grep -o ".*ron" | sed -e "s/ron//")
    if [ -n "${ron}" ]; then ron=$(echo "${ron}+300*${hon}"|bc); echo "  ron: ${ron}"; fi
    tsumo=$(echo ${score} | sed -r "s/.*ron-?//")
    if [ -n "${tsumo}" ]; then 
      child=$(echo ${tsumo} | sed -e "s/-.*//")
      child=$(echo "${child}+100*${hon}"|bc)
      parent=$(echo ${tsumo} | sed -e "s/.*-//")
      parent=$(echo "${parent}+100*${hon}"|bc)
      echo "  tsumo: ${child}-${parent}"
    fi
  fi

  rd

  if [ $(($RANDOM%4)) -ne 1 ]; then
    i=$(( (${i} + 1) % 4 ))
  fi
done



