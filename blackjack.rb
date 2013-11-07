# This is my first attempt at an OO blackjack game without using the solutions
class Blackjack
  attr_accessor :player, :dealer, :deck
  # needs to be like an engine that orchestrates the rest of classes
  def initialize
    @player = Player.new(Player.name)
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def run
    self.deal_cards
    self.show_flop
    # show_flop

    # player_turn
    # dealer_turn
    # who_won?
  end

  def deal_cards
    @player.hand = []
    @dealer.hand = []
    @player.hand << @deck.deal
    @dealer.hand << @deck.deal
    @player.hand << @deck.deal
    @dealer.hand << @deck.deal
  end

  def show_flop
    puts "Your first card is: #{@player.hand.first}"
    puts "Your second card is: #{@player.hand.last}"
  end

  def calculate_total(cards)
    # cards looks like this
    # [#Card:9890889 @suit='C', @value='9', #Card:98430 @suit='S', @value='2']
    total = 0

    

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
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|
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

class Player
  attr_accessor :name, :hand, :total

  def initialize(name)
    @name = name
  end

end

class Dealer
  attr_accessor :hand, :total

end

