
require 'rubygems'
require 'json'
require 'net/http'

ENTITY_TYPES = {
  'companies' => 'company',
  'financial-organizations' => 'finanacial-organization',
  'people' => 'person',
  'products' => 'product',
  'service-providers' => 'service-provider'
}

dir = Dir.open(ARGV[0])
dir.each { |file_name| 
  if file_name[0, 1] != '.'
    file_name_no_ext = file_name.gsub('.js', '')
    puts "File name: #{file_name}\n"
    entity_dir = "#{ARGV[0]}/#{file_name_no_ext}"
    puts "Dir to create: #{entity_dir}\n"
    Dir.mkdir entity_dir
    
    entity_type = ENTITY_TYPES[file_name_no_ext]

    json = IO.read("#{ARGV[0]}/#{file_name}")
    entities = JSON.parse(json)
    entities.each { |entity|
      File.open("#{entity_dir}/#{entity['permalink']}.js", 'w') { |file|
        Net::HTTP.get(URI.parse("http://api.crunchbase.com/v/1/#{entity_type}/#{entity['permalink']}.js"))
      }
    }
  end
}