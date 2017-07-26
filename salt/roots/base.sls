debconf-utils:
  pkg.installed

mysql_setup:
  debconf.set:
    - name: mysql-server
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': '{{ salt['pillar.get']('mysql:root_pw', '') }}' }
        'mysql-server/root_password_again': {'type': 'password', 'value': '{{ salt['pillar.get']('mysql:root_pw', '') }}' }
    - require:
      - pkg: debconf-utils

python-mysqldb:
  pkg.installed

mysql-server-5.6:
  pkg.installed:
    - require:
      - debconf: mysql-server
      - pkg: python-mysqldb

mysql:
  service.running:
    - watch:
      - pkg: mysql-server-5.6
      - file: /etc/mysql/my.cnf

/etc/mysql/my.cnf:
  file.managed:
    - source: salt://files/etc/mysql/my.cnf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: mysql-server-5.6
