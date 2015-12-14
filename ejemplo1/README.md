- Crear indice:
```
    curl -XPUT 'http://localhost:9200/blog/'
```
Por defecto crea 5 shards y 1 réplica

Ver estado:
```
    curl -XGET 'http://localhost:9200/_cluster/health?pretty'
```

Otras operaciones:

- Borrar índice:
```
    curl -XDELETE 'http://localhost:9200/blog/'
```
- Crear índice con parámetros:
```
    curl -XPUT 'http://localhost:9200/blog/' -d '{
      "settings": {
        "number_of_shards": 3,
        "number_of_replicas": 0
      }
    }'
```

Añadir un documento:
```
    curl -XPOST 'http://localhost:9200/blog/posts/1' -d '{
      "title": "Charla en Málaga",
      "body": "Nueva charla de linux-malaga en Málaga capital",
      "date": "2014-02-21",
      "published": true
    }'
```

Actualizar documento:
```
    curl -XPOST 'http://localhost:9200/blog/posts/1/_update' -d '{
      "doc": { "published": false }
    }'
```

Búsqueda:

```
curl -XGET 'http://localhost:9200/blog/posts/_search?q=title:charla&pretty'


curl -XGET 'http://localhost:9200/blog/posts/_search?q=title:malaga&pretty'
```

Instalar plugin kopf:

```
  bin/plugin install lmenezes/elasticsearch-kopf
```
