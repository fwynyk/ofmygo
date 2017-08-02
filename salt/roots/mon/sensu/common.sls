# configure the sensu repo
sensu_gpg:
  cmd.run:
    - name: wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | sudo apt-key add -
    - require_in:
      - pkgrepo.sensu-pkgrepo

sensu-pkgrepo:
  pkgrepo.managed:
    - humanname: Sensu
    - name: deb https://sensu.global.ssl.fastly.net/apt trusty main
    - file: /etc/apt/sources.list.d/sensu.list
    - keyid: 7580C77F
    - keyserver: keyserver.ubuntu.com
    - key_url: https://sensu.global.ssl.fastly.net/apt/pubkey.gpg
    - require_in:
      - pkg: sensu-package

# install the sensu-package
sensu-package:
  pkg.installed:
    - name: sensu
    - refresh: True

# tell plugins to use embeded ruby
sensu-embeded-ruby-true:
  file.replace:
  - name: /etc/default/sensu
  - pattern: EMBEDDED_RUBY=false
  - repl: EMBEDDED_RUBY=true

sensu-profile:
  file.append:
    - name: /etc/profile.d/sensu.sh
    - text:
        - EMBEDDED_RUBY=true

# checks that all hosts run
sensu-checks-all-json:
  file.managed:
    - name: /etc/sensu/conf.d/checks-all.json
    - source: salt://mon/sensu/checks-all.json
    - template: jinja
    - watch_in:
      - service: sensu-client


install_sensu_plugins:
  cmd.run:
    - names:
      - sensu-install -p load-checks  
      - sensu-install -p memory-checks 
      - sensu-install -p disk-checks  


# install public plugins and checks
sensu-symlink-public-plugins:
  file.symlink:
    - name: /etc/sensu/plugins
    - target: /opt/sensu/embedded/bin
    - force: True
    - require:
      - file: sensu-checks-all-json
      - cmd: install_sensu_plugins
