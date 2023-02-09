# From every Judgment for Costs of Appointed Attorney document, you have to fill a hash like the following:
#    {
#      :petitioner => “Frank Nunooruk, Jr.”,
#      :state =>  “State of Alaska”,
#      :amount => “$1,000.00”,
#      :date => “2021-12-08”
#    }

#use ruby-2.7.0
#В папку ./pdfs положить все .pdf файлы для парсинга 
require 'pdf/reader' # gem install pdf-reader
require 'json' # gem install json

FIELD_REGEX_MAP = {
  petitioner: /.+\s+(?<data>\S.+),(.|\n)+Petitioner/,
  state: /In the Supreme Court of the (?<data>.+)/,
  amount: /(?<data>\$\S+\d)/,
  date: /Date[^:]*: (?<data>\S+)/
}.freeze

def fetch_data(file_text)
  file_selection = {}
  FIELD_REGEX_MAP.each do |field, regex|
    file_match = regex.match(file_text)
    file_selection[field] = file_match ? file_match[:data] : nil
  end
  file_selection
end

result = {}

Dir["#{Dir.pwd}/pdfs/*.pdf"].each do |filename|
  file_text = PDF::Reader.open(filename) { |reader| reader.pages[0].text }
  result[filename] = fetch_data file_text
end

puts JSON.pretty_generate(result)


