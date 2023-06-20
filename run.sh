#!/bin/bash

start=$(date +%s.%N)



#configure the number of tests loops
number_c_tests=0
number_py_tests=1
number_node_tests=0
number_sh_tests=0

# compile the c
g++ -std=c++20 -g ./lib/MLog.cpp ./test/c_log4cxx_test.cpp -o ./test/log4cxx_test -lapr-1 -laprutil-1 -llog4cxx -ljsoncpp
    #cpp log4cxx test
for (( i=1; i<="$number_c_tests"; i++ )); do
    ./test/log4cxx_test
done

# python syslog test
for (( i=1; i<="$number_py_tests"; i++ )); do
    sudo cp -v lib/Log.py ~/lib/python/log.py
    python3 ./test/log_test.py
done

#javascript syslog test
for (( i=1; i<="$number_node_tests"; i++ )); do
    # node ./test/js_log_test_sysclient.js
    node ./test/js_log_test.js
done

#test system logger
for (( i=1; i<="$number_sh_tests"; i++ )); do
    logger --rfc5424=notq,notime,nohost "MNAV Test Shell Message"
done


end=$(date +%s.%N)
runtime=$(echo "$end-$start" | bc)
echo "Test Complete in $runtime seconds"