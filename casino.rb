require 'pry'
module Betting
  def pot(player)
    puts "Place your bets."
    bet = gets.to_i
    player.wallet -= bet
    if player.wallet < 0
      puts "Sorry insufficient funds"
      player.wallet += bet
      main_menu(@player_one)
      main_menu
    end
    puts "Placing the bet of #{bet}"
    bet
    pot = 0
    pot += bet
    puts "There is $#{pot} in the pot"
    pot
  end
end

class Person
  attr_accessor :name, :wallet
  def initialize(name, wallet)
    @name = name
    @wallet = wallet
  end
end
# This is our random event array
@rand_event = Array.new()
@rand_event << "You were mugged and lost $50"
@rand_event << "You lost your wallet! you have no money left"
@rand_event << "You trip on a wallet and find $100"
class Card
  attr_accessor :rank, :suit, :value

  def initialize(rank, suit, value)
    @rank = rank
    @suit = suit
    @value = value
  end
end

class Craps
  include Betting
  def dice
    die_one = rand(6) + 1
    die_two = rand(6) + 1
    puts die_one
    puts die_two
    total = die_one + die_two
  end

  def win(player, pot, roll)
    if roll == 7 || roll == 11
      puts "Congrats! You just won #{pot}"
      player.wallet += (pot * 2)
    else
      puts "sorry you lost"
    end
    puts "your wallet is now at #{player.wallet}"
  end
end

class Black_Jack
include Betting

  def deck
    ranks = {"A" => 11, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, "J" => 10, "Q" => 10, "K" => 10 }
    suits = %w{Spades Hearts Clubs Diamonds}
    stack_of_cards = suits.each_with_object([]) do |suit, res|
      ranks.each do |key, val|
        res << Card.new(key, suit, val)
      end
    end
    stack_of_cards
  end

def hand(deck)
    deck.shuffle!
    hand = []
     dealer_hand = []
     hand << deck.pop
     dealer_hand << deck.pop
     hand << deck.pop
     dealer_hand << deck.pop
    # deck.each { |card| puts card.rank + card.suit}
    hand.each {|hand| puts "#{hand.rank},#{hand.suit} is worth#{hand.value}"}
    # dealer_hand.each {|hand| puts  hand.rank + hand.suit}

    return hand, dealer_hand
  end

  def win(player, pot, hand)
    players_hand = hand[0][1].value + hand[0][0].value
    dealers_hand = hand[1][0].value + hand[1][1].value
    puts "Your hand comes to #{players_hand} and the dealers hand comes to #{dealers_hand}"
    if players_hand > dealers_hand && players_hand <= 21
      puts "Congrats! you won"
      player.wallet += (pot * 2)
    else
      puts "Sorry you lost"
    end
    puts "your wallet is now at #{player.wallet}"
  end
end

# player_one = Person.new("Colin", 10)

def setup
  puts "welcome to the Casino"
  puts "What is your name?"
  name = gets.strip
  puts "How much money do you have on you?"
  wallet = gets.to_i
  @player_one = Person.new(name, wallet)
end
def main_menu(player)
  while true
    puts "What game would you like to play"
    puts "1. Blackjack"
    puts "2. Craps"
    puts "3. Quit"
    case gets.to_i
      when 1
        black_jack = Black_Jack.new
        while true
          black_jack.win(player, black_jack.pot(player), black_jack.hand(black_jack.deck))
          puts "type quit to quit, or you can keep playing"
          break if gets.strip.downcase == 'quit'
        end
      when 2
          craps = Craps.new
        while true
          craps.win(player, craps.pot(player), craps.dice)
          puts "type quit to quit, or you can keep playing"
          break if gets.strip.downcase == 'quit'
        end
      when 3
        exit
    end
    #Random events go here Array.new(100, nothing happened)
    event = @rand_event.sample
    puts event
     case event
      when "You were mugged and lost $50"
        player.wallet -= 50
      when "You lost your wallet! you have no money left"
        player.wallet = 0
      when "You trip on a wallet and find $100"
        player.wallet += 100
    end
  end
end

 def exit
 	abort("Goodbye")
 end

main_menu(setup)
