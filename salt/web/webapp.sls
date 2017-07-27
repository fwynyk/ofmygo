install_golang:
  archive.extracted:
    - name: /usr/local/go
    - source: https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz 
    - archive_format: tar
    - source_hash: md5=f412132cdce75d41e3bcb0d68a33fc66
    - tar_options: --strip-components=1
