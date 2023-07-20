require 'csv'
require 'yaml'
require_relative 'write_to_file'

def convert_to_fixtures(file_path)
  file_name = file_path[/(\w+).csv$/,1]
  fixtures_section_name = file_name.singularize
  fixtures = {}

  CSV.foreach(file_path, headers: true) do |row|
    fixtures["#{fixtures_section_name}_#{row[0]}"] = row.to_hash.map do |k,v|
      if v.match(/\A\d*\Z/)
        value  = v.to_i
      else
        value = v
      end
      [k,value]
    end.to_h
  end
  write_to_file(fixtures.to_yaml.sub(/---\n/, ''), "#{file_name}.yml")
end
