### Creación BD mysql
Creamos la base de datos 'spain' e importamos los datos:
```
mysql  <municipios-geolocalizados.sql
```

### Importación desde Mysql a Elasticsearch
Utilizamos la api ruby tanto de mysql como de Elasticsearch para importar los datos.

Para ello instalar las gemas:

```
gem install mysql2
gem install elasticsearch
```

Ejecutamos el script:
```
./import.rb
```

### Consulta
Nuestro objetivo es ordenar las provincias según el número de municipios que tienen.
Esto se hace a través de Agregados:

```
    curl -XGET 'http://localhost:9200/spain/_search?pretty' -d '{
      "query": {
        "match_all": {}
      },
      "size": 0,
      "aggs": {
        "mun_por_provincia": {
          "terms": {
            "field": "provincia",
            "size": 52
          }
        }
      }
    }'
```


Si vemos los resultados, vemos que no funciona correctamente, nos devuelve cosas como:

```
  {
     "key": "valencia",
     "doc_count": 266
   },
   {
     "key": "valència",
     "doc_count": 266
   },
```

Esto es porque el campo provincia está analizado al importar y separa elementos como "valencia/valència" en dos.

### MAPPING Provincia para AGGS:
```
    curl -XDELETE 'http://localhost:9200/spain/'
    curl -XPUT 'http://localhost:9200/spain/'
    curl -XPUT 'http://localhost:9200/spain/municipios/_mapping' -d @mapping_prov1.json
    ./import.rb
```

Número de municipios por provincia:
```
    curl -XGET 'http://localhost:9200/spain/municipios/_search?pretty' -d '{
     "query": { "match_all" : {} },
     "size": 0,
     "aggs": {
      "mun_por_provincia": {
       "terms" : {
        "field" : "provincia.as_is",
        "size": 52
       }
      }
     }
    }'
```
### Sugerencias
```
{
  "suggest": {
    "my-suggestion": {
      "text": "fuengiorla",
      "term": {
        "field": "nombre"
      }
    }
  }
}
```
