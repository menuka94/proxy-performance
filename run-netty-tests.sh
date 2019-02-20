#!/usr/bin/env bash
declare -a arr=("500" "1024" "5120" "10240" "102400" "512000")
declare -a no_of_users=("100" "200" "500" "1000")

# clear existing results
#cd results/netty
#find . -type f -iname \*.csv -delete


for i in "${arr[@]}"
do
    for j in "${no_of_users[@]}"
        do
            jmeter -n -t "proxy-test.jmx" \
                -Jusers=$j \
                -Jsize=$i \
                -Jproxy=netty \
                -JserverName='localhost' \
                -Jport=8443 \
                -Jpath='' \
                -l results/netty/netty-payload$i-users$j.jtl
        done
done
