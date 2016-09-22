#!/bin/bash

/opt/hbase/hbase-1.0.0/bin/hbase zookeeper > logzoo.log 2>&1 &

/opt/hbase/hbase-1.0.0/bin/local-regionservers.sh start 2 2>&1

/opt/hbase/hbase-1.0.0/bin/hbase master --localRegionServers=0 start