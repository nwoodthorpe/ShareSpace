class RandomAlphaNumeric
  class << self
    def random_char
      random_0_to_35 = (Random.rand * 36).floor

      return random_0_to_35.to_s if random_0_to_35 < 10

      return ('A'..'Z').to_a[random_0_to_35 - 10]
    end

    def random_word(len)
      word = ""
      len.times do
        word += random_char
      end

      word
    end
  end
end
