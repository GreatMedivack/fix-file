VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

def create_mailing_list(source_file)
  file = File.new('./public/res.csv', 'w')
  result = CSV.open(file, 'w', quote_char: "\x00", col_sep: ';', headers: true)

  tmp_row = []

  CSV.readlines(source_file).each do |row|
    	array = []

    	array << filter_emails(row[22])
    	array << filter_emails(row[23])
    	array << filter_emails(row[24])
    	array.flatten!
    	array.each do |email| 
    		puts email.class
    		result << [row[2],email.to_s] if !email.empty?
    	end
    	puts array
    	puts "-"*80
    end
end

def filter_emails(string)
	string = "" if string.nil?
	tmp = string.split(',').map {|email| email.strip}
	tmp.select { |line| line =~ VALID_EMAIL_REGEX }
end