var Redis = require('ioredis');
  const redis = new Redis({
  sentinels: [
    { host: "127.0.0.1", port: 26379 },
  ],
  name: "mymaster",
});

const f = async function () {
  const channel = 'ioredis_channel'
  let messageCount = await redis.xlen(channel)
  console.log(`current message count in channel ${channel} is ${messageCount} messages`)
  const myMessage = 'hello world'
  await redis.xadd(channel, '*', myMessage, 'message')
  messageCount = await redis.xlen(channel)
  console.log(`current message count in channel ${channel} is ${messageCount} messages`)
  let messages = await redis.xread(['STREAMS', channel, 0])
  messages = messages[0][1]
  console.log(`reading messages from channel ${channel}, found ${messages.length} messages`)
  for (let i = 0; i < messages.length; i++) {
    let msg = messages[i]
    msg = msg[1][0].toString()
    console.log('reading message:', msg)
  }
  redis.on('connect', () => {
      console.log('[redis] connected');
    });
  redis.on('error', err => {
      console.error('[redis] error ', err);
    });
  process.exit(0)
}
f()

