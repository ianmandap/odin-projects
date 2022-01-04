def vig_cipher_encrypt(plaintext, key)
  plaintext.upcase!
  key.upcase!
  raise 'Error: Contains invalid characters' if /[^A-Z ]/.match(plaintext) || /[^A-Z]/.match(key)

  key = transform_key(plaintext, key)
  ciphertext = ''

  (0...plaintext.size).each do |num|
    if plaintext[num] == ' '
      ciphertext << ' '
    else
      shift = (plaintext[num].ord + key[num].ord) % 26 # A-Z 26 apart
      ciphertext << (shift + 65).chr # Character Code for A (65); Z (90)
    end
  end

  ciphertext
end

def vig_cipher_decrypt(ciphertext, key)
  ciphertext.upcase!
  key.upcase!
  raise 'Error: Contains invalid characters' if /[^A-Z ]/.match(ciphertext) || /[^A-Z]/.match(key)

  key = transform_key(ciphertext, key)
  plaintext = ''

  (0...ciphertext.size).each do |num|
    if ciphertext[num] == ' '
      plaintext << ' '
    else
      shift = (ciphertext[num].ord - key[num].ord) % 26 # A-Z 26 apart
      plaintext << (shift + 65).chr # Character Code for A (65); Z (90)
    end
  end

  plaintext
end

def transform_key(plaintext, key)
  transformed = key.ljust(plaintext.size, key)

  # insert spaces based on position indexes in plaintext
  plaintext.split('').each_with_index do |i, idx|
    next unless i == ' '

    transformed.insert(idx, ' ')
  end

  transformed[0...plaintext.size]
end

p vig_cipher_encrypt('Attack on Titans', 'POWER')
p vig_cipher_encrypt('attackatdawn', 'lemon')
p vig_cipher_decrypt('PHPETZ CJ XZIOJW', 'POWER')
p vig_cipher_decrypt('LXFOPVEFRNHR', 'lemon')
