### HBase standalone

#### Pull image
` docker pull sridhav/hbase`

#### Run hbase (interactive mode)
` docker run -p 60010:60010 -p 2181:2181 -p 60030:60030 -it sridhav/hbase`

#### Run Hbase (detached mode)
` docker run -p 60010:60010 -p 2181:2181 -p 60030:60030 -d -t sridhav/hbase`

#### Exposed ports

|Exposed Ports  | Usage |
|:------------------:| -------- |
|2181 | Zookeeper |
|60000| HBase Master API Port|
|60010| HBase Master Web UI |
|60020| HBase Region Server API Port |
|60030| HBase Region Server UI Port |


