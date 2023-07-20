require 'csv'
require 'yaml'
require 'active_support/all'

filename = "feature_categories.csv"
yaml_header = filename.sub(/.csv/, '').singularize

# CSV.foreach(filename) do |row|
#   p row
# end


# data = open('feature_categories.yml', 'r'){ |f| YAML.load(f) }
#
# yaml = data.to_yaml.sub(/---\n/, '')
#
# File.open("new.yml", "w+") do |f|
#   f.write(yaml)  # => 7
# end
#
# p data
#
# p yaml

def convert_to_fixtures(file_path)
  file_name = file_path[/(\w+).csv$/,1]
  fixtures_section_name = file_name.singularize
  fixtures = {}

  CSV.foreach(file_path, headers: true) do |row|
    # p row.to_hash.map { |k,v| [k,v]}.to_h
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

def write_to_file(data, file_name)
  File.open(file_name, "w+") do |f|
    f.write(data)
  end
end

if __FILE__ == $0
  if ARGV[0].nil?
    raise "Usage: ruby main.rb [csv file path]"
  end
  convert_to_fixtures(ARGV[0])
end

