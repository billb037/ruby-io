require 'json'
require 'phonelib'

class FileParser 
  EMAIL_REGEX =/^[A-Za-z0-9+_.-]+@([A-Za-z0-9]+\.)+[A-Za-z]{2,6}$/

  def initialze 
  end

  def parse_json 
    puts ">>>>> Going to parse some JSON!"
    @the_file = './lib/data/data.json'

    if !File.exist?(@the_file)
      p ">>> no file <<<"
      return nil
    end

    begin
      data_file = File.read(@the_file)
      data_hash = JSON.parse(data_file)
    rescue => e
      p "File Read Error\n" + e
      return nil
    end

    if data_hash.has_key?('sentiment_analysis')
      @data = data_hash['sentiment_analysis']
    else
      p ">>> Data is incomplete"
      return nil
    end
    
    emails = []
    phones = []

    if @data[0].has_key?('positive')
      @pos_total = sum_score(@data[0]['positive']) rescue begin
        p "*** Data error, no positive data"
        0
      end

      @data[0]['positive'].each do |d|
        d.each do |k,v|
          if k=="email" && is_email_valid?(v)
            emails.push(v)
          end
          if k=="phone" && ( Phonelib.valid?(v) || Phonelib.possible?(v) )
            phones.push(v)
          end
        end
      end
    end
    
    if @data[0].has_key?('negative')
      @neg_total = sum_score(@data[0]['negative']) rescue begin
        p "*** Data error, no negative data"
        0
      end

      @data[0]['negative'].each do |d|
        d.each do |k,v|
          if k=="email" && is_email_valid?(v)
            emails.push(v)
          end
          if k=="phone" && ( Phonelib.valid?(v) || Phonelib.possible?(v) )
            phones.push(v)
          end
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