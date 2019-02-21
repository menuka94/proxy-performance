#!/usr/bin/env bash
declare -a arr=("500" "1024" "5120" "10240" "102400" "512000")
declare -a no_of_users=("100" "200" "500" "1000")

# clear existing results
# cd results/esb
# find . -type f -iname \*.jtl -delete


for i in "${arr[@]}"
do
    for j in "${no_of_users[@]}"
        do
            jmeter -n -t "proxy-test.jmx" \
                -Jusers=$j \
                -Jsize=$i \
                -Jproxy=esb \
                -JserverName='Menukas-MacBook-Pro.local' \
                -Jport=8280 \
                -Jpath='/services/EchoEndpoint' \
                -l results/esb/esb-payload$i-users$j.jtl
        done
done


            jmeter -n -t "proxy-test.jmx" \
                -Jusers=500 \
                -Jsize=500 \
                -Jproxy=esb \
                -JserverName='Menukas-MacBook-Pro.local' \
                -Jport=8280 \
                -Jpath='/services/EchoEndpoint' \
                -l results/esb/esb-payload500-users500.jtl

