def write_to_file(data, file_name)
  File.open(file_name, "w+") do |f|
    f.write(data)
  end
end
