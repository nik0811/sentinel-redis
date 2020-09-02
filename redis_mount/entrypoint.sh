#!/bin/sh
sed -i "s/\$SENTINEL_PORT/$SENTINEL_PORT/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_MONITOR/$SENTINEL_MONITOR/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_DOWNTIME/$SENTINEL_DOWNTIME/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_FAILOVER/$SENTINEL_FAILOVER/g" /etc/redis/sentinel.conf
exec docker-entrypoint.sh redis-server /etc/redis/sentinel.conf --sentinel
