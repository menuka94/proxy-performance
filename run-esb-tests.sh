declare -a arr=("500" "1024" "5120" "10240" "102400" "512000")

# clear existing results
cd results/esb
find . -type f -iname \*.csv -delete


for i in "${arr[@]}"
do
    jmeter -n -t proxy-test.jmx -Jsize=$i -Jproxy=esb -JserverName='Menukas-MacBook-Pro.local' -Jport=8280 -Jpath='/services/EchoEndpoint'
done

