def convert_file(source_file)

  xls = Roo::Excelx.new(source_file)
  xls.to_csv("./public/file.csv",';',xls.sheets.first)

  file = File.new('./public/res.csv', 'w')
  result = CSV.open(file, 'w', quote_char: "\x00", col_sep: ';', headers: true)

  tmp_row = []

  CSV.open('./public/file.csv', quote_char: "\x00", col_sep: "\t").each do |row|
    str_fields = row[0].split(';')
    paid_status = str_fields[1].to_s.strip.slice(0, 254)
    accrual_date = str_fields[2].to_s.strip.slice(0, 254)

    if !paid_status.empty?
      tmp_row = str_fields
    elsif paid_status.empty?
      str_fields.each_with_index do |value, index|
        str_fields[index] = tmp_row[index] if str_fields[index].empty?
        str_fields[index] = tmp_row[index] if index == 6
      end
    else
      puts "Unknown value"
    end

    str_fields.map! { |x| x.empty? ? ' ' : x}
    result << str_fields if !accrual_date.empty?
  end                           

end