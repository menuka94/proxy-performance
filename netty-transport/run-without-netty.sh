#!/usr/bin/env bash
declare -a arr=("500" "1024" "5120" "10240" "102400" "512000")
declare -a no_of_users=("100" "200" "500" "1000")

# clear existing results
# cd results/with-netty
# find . -type f -iname \*.jtl -delete

# http://localhost:8280/default	

for i in "${arr[@]}"
do
    for j in "${no_of_users[@]}"
        do
            jmeter -n -t "proxy-test.jmx" \
                -Jusers=$j \
                -Jsize=$i \
                -JserverName='localhost' \
                -Jport=8280 \
                -Jpath='/default' \
                -l results/without-netty/without-netty-payload$i-users$j.jtl
        done
done
