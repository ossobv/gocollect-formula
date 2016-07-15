osso_repository:
  pkgrepo.managed:
    - name: deb http://ppa.osso.nl/{{ grains.os|lower }} {{ grains.oscodename }} osso
    - file: /etc/apt/sources.list.d/osso-ppa.list
    - key_url: https://ppa.osso.nl/support+ppa@osso.nl.gpg

osso_repository_src:
  pkgrepo.managed:
    - name: deb http://ppa.osso.nl/{{ grains.os|lower }} {{ grains.oscodename }} osso
    - file: /etc/apt/sources.list.d/osso-ppa.list
    - key_url: https://ppa.osso.nl/support+ppa@osso.nl.gpg

install_gocollect:
  pkg.latest:
    - pkgs:
      - gocollect
      {% if grains.virtual == 'physical' %}
      - gocollect-hardware
      {% endif %}
    - require:
      - pkgrepo: osso_repository
      - file: /etc/gocollect.conf

/etc/gocollect.conf:
  file.managed:
    - source: salt://gocollect-formula/files/etc/gocollect.conf
    - template: jinja
    - context: {{ salt['pillar.get']('gocollect:conf', {}) }}
