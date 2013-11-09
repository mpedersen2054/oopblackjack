require 'pry'
# practicing the implementation from OOP solutions 1-2

class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def pretty_output
    puts "The #{face_value} of #{suit_full}"
  end

  def suit_full
    case suit
      when 'H' then 'Hearts'
      when 'H' then 'Hearts'
      when 'H' then 'Hearts'
      when 'H' then 'Hearts'
    end
  end
end

class Deck
  def initialize
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end
  
end

class Player
end

class Dealer
end

class Hand
end

c1 = Card.new('H', '6')
c1.pretty_output

binding.pry













