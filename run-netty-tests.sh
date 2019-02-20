declare -a arr=("500" "1024" "5120" "10240" "102400" "512000")

# clear existing results
cd results/netty
find . -type f -iname \*.csv -delete

for i in "${arr[@]}"
do
    jmeter -n -t proxy-test.jmx -Jsize=$i -Jproxy=netty -JserverName='localhost' -Jport='8443'
done

