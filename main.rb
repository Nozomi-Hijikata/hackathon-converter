require 'csv'
require 'yaml'
require 'active_support/all'
require './lib/convert_to_csv'
require './lib/convert_to_fixtures'

def main(file_path)
  if file_path.match(/.csv\z/)
    convert_to_fixtures(file_path)
  elsif file_path.match(/.yml\z/)
    convert_to_csv(file_path)
  else
    raise "File must be a .csv or .yml file"
  end
end

if __FILE__ == $0
  if ARGV[0].nil?
    raise "Usage: bundle exec ruby main.rb [file path]"
  end
  main(ARGV[0])
end

