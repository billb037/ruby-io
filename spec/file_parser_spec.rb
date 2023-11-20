require_relative  '../lib/file_parser'

describe FileParser do
  parser = FileParser.new

  describe "#is_email_valid" do
    it "returns 0 if email is valid format" do 
      expect(parser.is_email_valid?("joe@dirt.com")).to eq(0)
    end
    it "returns nil if email is invalid format" do
      expect(parser.is_email_valid?("joe@dirt")).to eq(nil)
    end
  end

  describe "#sum_score" do 
    it "should sum all scores from array" do
      expect(parser.sum_score([{"score"=>1.1},{"score"=>2.1}])).to eq(3.2)
    end
  end
end
