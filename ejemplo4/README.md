AUTOCOMPLETE
============

Ejemplo de autocompletado en el campo nombre del municipio

    curl -XDELETE 'http://localhost:9200/_river/lima_river/'
    curl -XDELETE 'http://localhost:9200/spain/'
    curl -XPUT 'http://localhost:9200/spain/' -d @settings_municipios.json
    curl -XPUT 'http://localhost:9200/spain/municipios/_mapping' -d @mapping_prov2.json
    curl -XPUT 'http://localhost:9200/_river/lima_river/_meta' -d @river.json

    curl "http://localhost:9200/spain/municipios/_search?q=nombre_auto:fuen&pretty=true"

