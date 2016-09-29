#!/usr/bin/env ruby
require 'rubygems'
require 'elasticsearch'
require 'mysql2'

client = Elasticsearch::Client.new

conn = Mysql2::Client.new(host:'localhost', username:'root', password:'', database:'spain')

body = []
res=conn.query('select m.id, p.provincia, m.municipio from provincias p, municipios m where m.provincia_id=p.id;')
res.each do |row|
	body << { index: {
			_index: 'spain',
			_type:'municipios',
			_id:row['id_municipio'],
				data: {
					nombre: row['municipio'].force_encoding('UTF-8'),
					provincia: row['provincia'].force_encoding('UTF-8')
				}
			 }
		}
end

client.bulk body: body
