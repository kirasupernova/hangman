# HAnGMAN: computer randomly selects word from library, player has to guess
# What should be in classes?
#     class Hangman -> selects and stores word, correctly guessed letters, wrongly guessed letters
#     class Player -> stores name

class Hangman

  attr_accessor :word, :correct_guesses, :false_guesses

  def initialize
    @word = select_word
    @correct_guesses = word_underscores(@word)
    @false_guesses = ''
  end

  def select_word
    dictionary = File.open("../5desk.txt", "r")
    dictionary.readlines.filter { |word| word != word.capitalize && word.chomp.length.between?(5, 12) }.sample.chomp
  end

  def word_underscores(word)
    word.downcase.gsub(/[a-z]/, '_')
  end

  def guess(guess)
    if self.word.include?(guess)
      place_correct_letter(guess)
    else
      place_false_letter(guess)
    end
  end

  def place_correct_letter(guess)
    self.word.split('').each_with_index do |letter, index|
      next if letter != guess

      self.correct_guesses[index] = letter
    end
  end

  def place_false_letter(guess)
    self.false_guesses += guess
    self.false_guesses.split('').sort.join('')
  end

  def won?
    self.correct_guesses == self.word
  end
end

