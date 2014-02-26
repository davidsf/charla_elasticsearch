### IMPORTACION DESDE MYSQL
Instalación del river jdbc en Elasticsearch 1.0:

    ./bin/plugin --install river-jdbc --url http://bit.ly/1jyXrR9

    curl -XPUT 'http://localhost:9200/_river/lima_river/_meta' -d @river.json

Borramos el river una vez importados:

    curl -XDELETE 'http://localhost:9200/_river/lima_river/'

FACETS:

    curl -XGET 'http://localhost:9200/spain/_search?pretty' -d '{
     "query": { "match_all" : {} },
     "facets": {
      "my_query_facet": {
       "terms" : {
        "field" : "provincia",
        "size": 52
       }
      }
     }
    }'

Esto no funciona porque el campo provincia está analizado al importar.

### MAPPING Provincia para FACETS:

    curl -XDELETE 'http://localhost:9200/spain/municipios/'
    curl -XPUT 'http://localhost:9200/spain/municipios/_mapping' -d @mapping_prov1.json
    curl -XPUT 'http://localhost:9200/_river/lima_river/_meta' -d @river.json

    curl -XGET 'http://localhost:9200/spain/municipios/_search?pretty' -d '{
     "query": { "match_all" : {} },
     "size": 0,
     "facets": {
      "my_query_facet": {
       "terms" : {
        "field" : "prov_as_is",
        "size": 52
       }
      }
     }
    }'
