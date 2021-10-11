def create_companies_list(source_file)


  file = File.new('./public/file.csv', 'w')
  result = CSV.open(file, 'w')

  array = []

  CSV.readlines(source_file).each do |row|
    puts row[2]
    array << row[2]
  end

  array.uniq!
  array.flatten!
  array.shift

  array.each do |el|
    result << [el]
  end
end