#!/bin/bash

#mainly to debug locally
if [ -z $SERVICE_DIR ]; then export SERVICE_DIR=`pwd`; fi
if [ -z $ENV ]; then export ENV=IUHPC; fi

#rm -f finished

# Steven's code
cp ~/dtiinit.tar.gz ./ && tar -xf dtiinit.tar.gz && rm dtiinit.tar.gz

echo $ENV > testing

if [ $ENV == "IUHPC" ]; then

    jobid=`qsub $SERVICE_DIR/submit.pbs`
    echo $jobid > jobid
fi

if [ $ENV == "VM" ]; then
    nohup time $SERVICE_DIR/submit.pbs > stdout.log 2> stderr.log &
    echo $! > pid
fi

