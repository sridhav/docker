zookeeper-server-start -daemon /etc/kafka/zookeeper.properties
export JMX_PORT=${JMX_PORT:-9991}
kafka-server-start -daemon /etc/kafka/server.properties