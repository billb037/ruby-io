require 'json'
require 'phonelib'

class FileParser 
  @the_file = ''
  EMAIL_REGEX =/^[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}$/

  def initialze 
    puts ">>>>> in Parser!"
    @the_file = './lib/data/data.json'
  end

  def parse_json 
    puts ">>>>> Going to parse some JSON!"

    data_file = File.read('./lib/data/data.json')
    data_hash = JSON.parse(data_file)
    data = data_hash['sentiment_analysis']

    @pos_total = sum_score(data[0]['positive'])
    @neg_total = sum_score(data[0]['negative'])

    # puts ">>>>> Positive Grand Total: #{@pos_total}"
    # puts ">>>>> Negative Grand Total: #{@neg_total}"

    emails = []
    phones = []

    data[0]['positive'].each do |d|
      d.each do |k,v|
        if k=="email" && is_email_valid?(v)
          emails.push(v)
        end
        if k=="phone" && ( Phonelib.valid?(v) || Phonelib.possible?(v) )
          phones.push(v)
        end
      end
    end 
    
    data[0]['negative'].each do |d|
      d.each do |k,v|
        if k=="email" && is_email_valid?(v)
          emails.push(v)
        end
        if k=="phone" && ( Phonelib.valid?(v) || Phonelib.possible?(v) )
          phones.push(v)
        end
      end
    end 
    p emails.to_json
    p phones.to_json
  end

  def is_email_valid? email
      email =~ EMAIL_REGEX
  end

  def sum_score scores 
    total_scores = 0
    scores.each {|x| total_scores=total_scores+x['score'].to_f}
    total_scores
  end
end