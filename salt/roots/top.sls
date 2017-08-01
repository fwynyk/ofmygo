base:
  '*':
    - mon.git
    - mon.sensu.client
  'database':
    - db.database 
  'webapp':
    - web.webapp
  'monitoring':
    - mon.rabbitmq.server
    - mon.redis.server
    - mon.sensu.server
