require 'pry'

# this is the code from blackjack solutions 1
# behaviors - think about instance methods
# states - think about instance variables

class Card
  attr_accessor :suit, :face_value

  def initialize(suit, face_value)
    @suit = suit
    @face_value = face_value
  end

  def pretty_output
    "The #{face_value} of #{find_suit}"
  end

  def find_suit
    case suit
      when "H" then "Hearts"
      when "D" then "Diamonds"
      when "C" then "Clubs"
      when "S" then "Spades"
    end
  end

  def to_s
    pretty_output
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []

    ['H', 'C', 'D', 'S'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', 'J', 'Q', 'K', 'A'].each do |value|
        @cards << Card.new(suit, value)
      end
    end
    shuffle
  end

  def shuffle
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand
  def show_hand
    puts "#{name}'s hand:"
    cards.each do |card|
      puts "---> #{card}"
    end
    puts "---> #{total}"
  end

  def total
    face_value = cards.map { |card| card.face_value }

    total = 0

    face_value.each do |val|
      if val == 'A'
        total += 11
      elsif val.to_i == 0
        total += 10
      else
        total += val.to_i
      end
    end

    face_value.select {|x| x == 'A'}.count.times do
      if total > 21
        total -= 10
      end
    end
    total
    puts "#{name}'s total is: #{total}"
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > 21
  end
end

class Player
  include Hand

  attr_accessor :cards, :name

  def initialize(name)
    @name = name
    @cards = []
  end
end

class Dealer
  include Hand

  attr_accessor :cards, :name

  def initialize
    @name = "Dealer"
  end
end



deck = Deck.new

c1 = Card.new('D', '6')

player = Player.new("Matt")
player.add_card(deck.deal_one)
player.add_card(deck.deal_one)
player.show_hand

binding.pry















