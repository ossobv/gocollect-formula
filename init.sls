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

gocollect:
  pkg.latest:
    - require:
      - pkgrepo: osso_repository

{% if grains.virtual == 'physical' %}
gocollect-hardware:
  pkg.latest:
    - require:
      - pkgrepo: osso_repository
{% endif %}

/etc/gocollect.conf:
  file.managed:
    - source: salt://gocollect-formula/files/etc/gocollect.conf
    - context: {{ salt['pillar.get']('gocollect:conf', {}) }}
