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
end
