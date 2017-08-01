rabbitmq-server:

  pkg.installed:
    - name: rabbitmq-server

  file.managed:
    - name: /etc/rabbitmq/rabbitmq.config
    - contents: |
        [
            {rabbit, [
            {ssl_listeners, [5671]}
          ]}
        ].

    - require:
      - pkg: rabbitmq-server   

  service.running:
    - watch:
      - pkg: rabbitmq-server   
      - file: rabbitmq-server   

