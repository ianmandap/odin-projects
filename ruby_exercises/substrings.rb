# frozen_string_literal: true

def substrings(arg, dict_array)
  arg_array = arg.split
  hash = Hash.new(0)

  arg_array.each do |word|
    dict_array.each do |substr|
      hash[substr.downcase] += 1 if word.downcase.include?(substr.downcase)
    end
  end

  hash
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
p substrings('below', dictionary) #=> { "below" => 1, "low" => 1 }

p substrings("Howdy partner, sit down! How's it going?", dictionary)
#=> { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
