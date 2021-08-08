require 'yaml'
require './hangman'
require './player'

def init
  puts 'Welcome to Hangman!'
  puts "What's your name?"
  name = gets.chomp
  game = savegame(name)
  hangman = game[0]
  player = game[1]
  play(player, hangman)
  game_end(player, hangman)
end

def savegame(name)
  if File.exist?("../savegames/#{name}.yaml")
    file = YAML.load(File.read("../savegames/#{name}.yaml"))
    player = file[0]
    puts "Would you like to load your safefile, #{name}? (Y/N)"
    answer = gets.chomp.downcase
    if answer == 'y'
      hangman = file[1]
    else 
    hangman = Hangman.new
    end
  else
    player = Player.new(name)
    hangman = Hangman.new
  end
  [hangman, player]
end

def play(player, hangman)
  until hangman.won? || hangman.false_guesses.length == 10
    print "Correct guesses:"
    puts hangman.correct_guesses
    print "False guesses:"
    puts hangman.false_guesses
    puts "Make your guess, #{player.name}.\nYou have #{10 - hangman.false_guesses.length} guesses left."
    input = gets.chomp.downcase
    commands(input, player, hangman)
    hangman.guess(input)
  end
end

def commands(input, player, hangman)
  return unless input == 'save'

  savegame = [player, hangman]
  File.open("../savegames/#{player.name}.yaml", "w") { |file| file.write(YAML.dump(savegame)) }
  puts "See you next time, #{player.name}"
  exit
end

def game_end(player, hangman)
  if hangman.won?
    puts "Congratulations #{player.name}, you guessed the word in time!"
    player.wins += 1
  else
    puts "The word was #{hangman.word}! Better luck next time, #{player.name}."
    player.losses += 1
  end
  commands('save', player, Hangman.new)
end

init
