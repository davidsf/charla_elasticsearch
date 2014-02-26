En el ejemplo anterior no funciona la consulta:

    curl -XGET 'http://localhost:9200/blog/posts/_search?q=title:malaga&pretty'

    curl -XDELETE 'http://localhost:9200/blog/'
    curl -XPUT 'http://localhost:9200/blog/' -d @settings.json
    curl -XPUT 'http://localhost:9200/blog/posts/_mapping' -d @mapping.json

    curl -XPOST 'http://localhost:9200/blog/posts/1' -d '{
      "title": "Charla en Málaga",
      "body": "Nueva charla de linux-malaga en Málaga capital",
      "date": "2014-02-21",
      "published": true
    }'

Ahora si funciona la búsqueda: 

    curl -XGET 'http://localhost:9200/blog/posts/_search?q=title:malaga&pretty'

Otros tipos de consultas:

    curl -XGET 'http://localhost:9200/blog/posts/_search?pretty' -d '{
      "query": {
        "match": { "title": "malaga charla" }
      }
    }'


    curl -XGET 'http://localhost:9200/blog/posts/_search?pretty' -d '{
      "query": {
        "match": { 
           "title": { 
              "query": "malaga charla", 
              "operator": "and" 
            } 
          }
      }
    }'

    curl -XGET 'http://localhost:9200/blog/posts/_search?pretty' -d '{
      "query": {
        "query_string": {
          "query": "+title:charla +body:malaga"
        }
      }
    }'


Búsqueda en todo el índice y en todos los campos:

    curl -XPOST 'http://localhost:9200/blog/user/1' -d '{
      "name": "David Sedeño",
      "city": "Fuengirola",
      "province": "Malaga"
    }'

    curl -XGET 'http://localhost:9200/blog/_search?q=malaga&pretty'

