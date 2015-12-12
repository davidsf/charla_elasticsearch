#!/usr/bin/env ruby
require 'rubygems'
require 'elasticsearch'
require 'mysql'

client = Elasticsearch::Client.new

conn = Mysql.new 'localhost', 'root', '', 'spain'

body = []
res=conn.query('select m.id, m.latitud, m.longitud, p.provincia, m.municipio,c.comunidad from provincias p, municipios m, comunidades c where m.provincia_id=p.id and p.comunidad_id=c.id ;')
res.each_hash do |row|
	body << { index: {
			_index: 'spain2',
			_type:'municipios',
			_id:row['id_municipio'],
				data: {
					nombre: row['municipio'].force_encoding('UTF-8'),
					provincia: row['provincia'].force_encoding('UTF-8'),
					comunidad: row['comunidad'].force_encoding('UTF-8'),
					location: {
						lon: row['longitud'],
						lat: row['latitud']
					}
				}
			 }
		}
end

client.bulk body: body
