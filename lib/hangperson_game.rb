class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end


  def guess(charac)
    if charac == "" || charac.nil?
        raise ArgumentError
    end
    if /[[:alpha:]]/ !~ charac
        puts(charac)
        raise ArgumentError
    end
    charac = charac.downcase
    if word.include?(charac)
        if guesses.include?(charac) == false
            guesses << charac
            return true
        end
    else
        if wrong_guesses.include?(charac) == false
            wrong_guesses << charac
            return true
        end
    end
    return false
  end

   def word_with_guesses()
    val = Array.new(word.length, "-")
    for c in guesses.split("") do
        temp = Array.new(0)
        for i in  0 ... word.length do
            if c == word[i]
                temp.push(i)
            end
        end
        for elem in temp do
            val[elem] = c
        end
    end
    return val.join()
   end

   def check_win_or_lose()
    val = word_with_guesses()
    if val == word
        return :win
    elsif wrong_guesses.length >= 7
        return :lose
    else
        return :play
    end
   end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
