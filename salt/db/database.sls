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
    - source: salt://files/database/etc/mysql/my.cnf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: mysql-server-5.6

user_webapp:
  mysql_user.present:
    - name: webapp
    - host: '%'
    - password_hash: '*6167CC1E57CD7284D48504A5E806397E375FBE32'
  mysql_grants.present:
    - grant: insert, update, select, delete, create, drop
    - database: 'gowebapp.*'
    - user: webapp
    - host: '%'
