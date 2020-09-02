FROM redis:latest
ADD redis_mount/sentinel.conf /etc/redis/sentinel.conf
RUN chown redis:redis /etc/redis/sentinel.conf
ENV SENTINEL_MONITOR 2
ENV SENTINEL_DOWNTIME 5000
ENV SENTINEL_FAILOVER 60000
ENV SENTINEL_PORT 5000
ADD redis_mount/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
