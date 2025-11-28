#!/bin/bash

# generate a file of endpoints for jmeter agents for a distributed workload

# example output:

#      - 10.244.0.196
#      - 10.244.0.197
#      - 10.244.0.198

# the contents of the output file can be inserted via a sed command to the "distributed" block of the Taurus yaml files

if [ "$#" != 1 ]; then
    echo "Fatal: No path to yaml in arguments"
    echo "Usage: $0 <path_to_yaml>"
    exit 1
fi

if [ -e $1 ]; then
    kubectl get endpoints jmeter-agents   -o jsonpath='{range .subsets[*].addresses[*]}      - {.ip}{"\n"}{end}'   > distributed_hosts

    sed -i '/<distributed>/ {
        r distributed_hosts
        d
    }' $1
else
    echo "Fatal: No file at $1 exists"
    exit 1
fi

