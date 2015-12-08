#!/usr/bin/env ruby
require 'rubygems'
require 'elasticsearch'
require 'mysql'

client = Elasticsearch::Client.new

conn = Mysql.new 'localhost', 'root', '', 'spain'

body = []
res=conn.query('select id_municipio, p.provincia, m.nombre from provincias p, municipios m where m.id_provincia=p.id_provincia;')
res.each_hash do |row|
	body << { index: {
							_index: 'spain',
							_type:'municipios',
							_id:row['id_municipio'],
							data: {
								nombre: row['nombre'].force_encoding('UTF-8'),
								provincia: row['provincia'].force_encoding('UTF-8')
							}
					 }
				}
end

client.bulk body: body
