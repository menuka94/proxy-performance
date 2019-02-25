#!/usr/bin/env bash
# Run the JTL-Splitter script on every results file

declare -a payloads=("500" "1024" "5120" "10240" "102400" "512000")
declare -a users=("100" "200" "500" "1000")


proxy=without-netty
resultsDir=results/$proxy

for i in "${payloads[@]}"
do
    for j in "${users[@]}"
        do
            file=$resultsDir/$proxy-payload$i-users$j.jtl
            newfolder=$resultsDir/$proxy-payload$i-users$j
            if [ ! -f $file ]; then
               echo "File not found! $file"
               continue
            fi
            ../jtl-splitter.sh -- -f $file -t 1 -s && \
            mkdir -p $newfolder && \
            mv $resultsDir/$proxy-payload$i-users$j-measurement-summary.json $newfolder && \
            mv $resultsDir/$proxy-payload$i-users$j-warmup-summary.json $newfolder && \
            mv $resultsDir/$proxy-payload$i-users$j-measurement.jtl $newfolder && \
            mv $resultsDir/$proxy-payload$i-users$j-warmup.jtl $newfolder
        done
done

# ./jtl-splitter.sh -- -f results/with-netty/with-payload500-users500.jtl -t 1 -s
