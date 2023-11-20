require_relative 'file_parser'

class Main 
  parser = FileParser.new
  res = parser.parse_json
  puts res.to_json
end
