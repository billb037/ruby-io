require_relative 'file_parser'

class Main 
  parser = FileParser.new
  puts '>>> In Main'

  parser.parse_json
end
