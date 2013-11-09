require 'pry'
# This is my first attempt at an OO blackjack game without using the solutions
class Blackjack
  @@playertotal = 0
  @@dealertotal = 0

  attr_accessor :player, :dealer, :deck
  # needs to be like an engine that orchestrates the rest of classes
  def initialize
    @player = Player.new(Player.name)
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def run
    deal_cards
    show_flop

    # player_turn
    # dealer_turn
    # who_won?
  end

  def deal_cards
    player.hand << deck.deal
    dealer.hand << deck.deal
    player.hand << deck.deal
    dealer.hand << deck.deal
  end

  def show_flop
    puts "Your first card is: #{player.hand[0]}"
    puts "Your second card is: #{player.hand[1]}"
  end

  def player_turn
    puts "Enter '1' into the prompt to hit, '2' to stay..."
    answer = gets.chomp
    if answer == '1'
      #hit
    elsif answer == '2'
      #stay
    else
      puts "Please enter '1' or '2'"
    end
  end

end

class Card
  attr_accessor :suit, :value

  def initialize(s, v)
    @suit = s
    @value = v
  end

  def to_s
    "The #{value} of #{suit}"
  end

end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['Hearts', 'Diamonds', 'Spades', 'Clubs'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    scramble
  end

  def scramble
    cards.shuffle!
  end

  def deal
    cards.pop
  end
end

module Hand
  attr_accessor :hand

  def suits

  end

  def calculate_value(cards)
    value = cards.select { |x| x }

  end
end

class Player
  include Hand
  attr_accessor :name

  def initialize(name)
    @name = name
    @hand = []
  end

end

class Dealer
  include Hand

  def initialize
    @hand = []
  end
end





















