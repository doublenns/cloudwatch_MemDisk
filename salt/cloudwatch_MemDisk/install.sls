install_dependencies:
  pkg.installed:
    - pkgs:
      {% if grains['osfullname'] == 'Ubuntu' %}
        #- unzip
        - libwww-perl
        - libdatetime-perl
      {% elif grains['osfullname'] == 'Amazon Linux AMI' %}
        - perl-Switch
        - perl-DateTime
        - perl-Sys-Syslog
        - perl-LWP-Protocol-https
      {% endif %}

create cloudwatch user/group:
  group:
    - present
    - name: cloudwatch
  user:
    - present
    - name: cloudwatch
    #- shell: nologin
    - home: /home/cloudwatch
    - groups:
      - cloudwatch

#create directory for scripts:
#  file.directory:
#    - name: /home/cloudwatch/memDisk
#    - user: cloudwatch
#    - group: cloudwatch
#    - mode: 755
#    - makedirs: True

download Amazon MemDisk Scripts:
  archive.extracted:
    - name: /home/cloudwatch/cloudwatch_MemDisk_Scripts-1.2.1
    - source: http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip
    - source_hash: md5=939508e2fed7620625ba43fbd2668c6b
    - user: cloudwatch
    - group: cloudwatch
