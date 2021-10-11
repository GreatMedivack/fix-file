VALID_PHONE_NUMBER_REGEX = /\+?(\d\-?)+( доб\. )?/
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

def create_contacts_list(source_file)
  file = File.new('./public/res.csv', 'w')
  result = CSV.open(file, 'w', col_sep: ';', headers: true)

  tmp_row = []
  companies = read_companies
  CSV.readlines(source_file).each do |row|
      next unless companies.include? row[5]
      contact_name = row[2].to_s.strip
      position = row[59].to_s.strip
      #Emails
      emails = []
    	emails << filter_emails(row[24])
    	emails << filter_emails(row[25])
    	emails << filter_emails(row[26])
      #Phones
      phones = []
      phones << filter_phones(row[18])
      phones << filter_phones(row[19])
      phones << filter_phones(row[20])
      phones << filter_phones(row[21])
      phones << filter_phones(row[22])
      phones << filter_phones(row[23])

      emails.flatten!
    	phones.flatten!

      array = 
            if emails.size >= phones.size
              emails.each_with_index.map {|x, i| [contact_name.to_s,position.to_s,row[5].to_s,x.to_s,phones[i].to_s]}
            else
              phones.each_with_index.map {|x, i| [contact_name.to_s,position.to_s,row[5].to_s,emails[i].to_s,x.to_s]}
            end

      array.each do |array|
        result << array.flatten unless (array[3].empty? && array[4].empty?) || (array[0].empty? && array[1].empty?)
      end  

    end
end

def filter_emails(string)
  string = "" if string.nil?
  tmp = string.split(',').map {|email| email.strip}
  tmp.select { |line| line =~ VALID_EMAIL_REGEX }
end

def filter_phones(string)
	string = "" if string.nil?
	tmp = string.split(',').map {|phone| phone.gsub(/\'/,'')}
	tmp.select { |line| line =~ VALID_PHONE_NUMBER_REGEX }
end

def read_companies
  res = []
  file = File.open('./public/file.csv','r')
  CSV.readlines(file).each do |row|
    res << row[0]
  end
  res.flatten
end
