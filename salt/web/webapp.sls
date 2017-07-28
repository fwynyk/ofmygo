git:
  pkg.installed:
  - pkgs:
    - git
    - mysql-client

install_golang:
  archive.extracted:
    - name: /usr/local/go
    - source: https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
    - archive_format: tar
    - source_hash: md5=f412132cdce75d41e3bcb0d68a33fc66
    - tar_options: --strip-components=1

set_vars:
  file.append:
    - name: /etc/profile.d/setvars.sh
    - text:
        - export GOPATH=/home/vagrant
        - export GOROOT=/usr/local/go
        - export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

env_vars:
   environ.setenv:
     - name: vars
     - value:
         GOPATH: '/home/vagrant'
         GOROOT: '/usr/local/go'
         PATH: '$PATH:/usr/local/go/bin:/home/vagrant/bin:/usr/bin:/bin'

install_dependencies:
  cmd.run:
    - names: 
      - go get github.com/gorilla/context
      - go get github.com/gorilla/sessions
      - go get github.com/go-sql-driver/mysql
      - go get github.com/haisum/recaptcha
      - go get github.com/jmoiron/sqlx
      - go get github.com/josephspurrier/csrfbanana
      - go get github.com/julienschmidt/httprouter
      - go get github.com/justinas/alice
      - go get github.com/mattn/go-sqlite3
      - go get golang.org/x/crypto/bcrypt
      - go get github.com/boltdb/bolt
      - go get gopkg.in/mgo.v2
      - go get github.com/josephspurrier/gowebapp
      - chown vagrant.vagrant /home/vagrant -R

/home/vagrant/gowebapp.sh:
  file.managed:
    - source: salt://files/gowebapp.sh
    - user: vagrant
    - group: vagrant
    - mode: 755

/home/vagrant/src/github.com/josephspurrier/gowebapp/config/config.json:
  file.managed:
    - source: salt://files/config.json
    - user: vagrant
    - group: vagrant
    - mode: 644

database:
  cmd.run:
    - cwd: /home/vagrant/src/github.com/josephspurrier/gowebapp
    - name: mysql -u webapp -pchange123me -hdatabase < config/mysql.sql

go_build:
  cmd.run:
    - cwd: /home/vagrant/src/github.com/josephspurrier/gowebapp
    - names:
      - go build gowebapp.go
