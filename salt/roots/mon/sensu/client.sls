include:
  - mon.sensu.common

sensu-client-json:
  file.managed:
    - name: /etc/sensu/conf.d/client.json
    - source: salt://mon/sensu/client-config.json
    - template: jinja

sensu-client:
  service.running:
    - name: sensu-client
    - require:
      - pkg: sensu-package
    - watch:
      - file: sensu-client-json
      - file: sensu-checks-all-json
