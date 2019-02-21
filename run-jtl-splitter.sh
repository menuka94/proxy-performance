#!/usr/bin/env bash
# Run the JTL-Splitter script on every results file

declare -a payloads=("500" "1024" "5120" "10240" "102400" "512000")
declare -a users=("100" "200" "500" "1000")


proxy=netty

for i in "${payloads[@]}"
do
    for j in "${users[@]}"
        do
            file=results/$proxy/$proxy-payload$i-users$j.jtl
            newfolder=results/$proxy/$proxy-payload$i-users$j
#            if [ ! -f file ]; then
#               echo "File not found! $file"
#               continue
#            fi
            ./jtl-splitter.sh -- -f $file -t 5 -s && \
            mkdir $newfolder && \
            mv $proxy-payload$i-users$j-measurement-summmary.json $newfolder && \
            mv $proxy-payload$i-users$j-warmup-summmary.json $newfolder && \
            mv $proxy-payload$i-users$j-measurement.jtl $newfolder && \
            mv $proxy-payload$i-users$j-warmup.jtl $newfolder
        done
done

