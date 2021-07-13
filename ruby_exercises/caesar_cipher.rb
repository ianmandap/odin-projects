def caesar_cipher(string, num)
  # Takes in a string and shift factor (num) to output a modified string
  string.split('').reduce([]) { |arr, char|
    char_code = char.ord

    if char_code.between?(65, 90)
      # Uppercase letters
      char_code += num
      (char_code -= 26) while char_code > 90
      (char_code += 26) while char_code < 65
    end

    if char_code.between?(97, 122)
      # Lowercase letters
      char_code += num
      (char_code -= 26) while char_code > 122
      (char_code += 26) while char_code < 97
    end

    arr << char_code.chr
  }.join('')
end

p caesar_cipher("What a string!", 5) #=> "Bmfy f xywnsl!"
p caesar_cipher("Bmfy f xywnsl!", -5)
p caesar_cipher('Hello, World!', 75)
p caesar_cipher('Hello, World!', -55)