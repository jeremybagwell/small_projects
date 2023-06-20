export MNAV_STEALTHAPP_LOG_ROOT="../mnav-logging/logging/config"

g++ -std=c++20 test_lib.cpp -o test_lib -lmnavlogging -llog4cxx -lapr-1 -laprutil-1 
./test_lib

