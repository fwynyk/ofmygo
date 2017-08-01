redis-server:
  
  pkg.installed:
    - name: redis-server

  service.running:
    - name: redis-server
