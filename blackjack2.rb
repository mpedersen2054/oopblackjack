require 'pry'
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
    puts "---> for a total of: #{total}"
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
      if total > Blackjack::BLACKJACK_AMOUNT
        total -= 10
      end
    end
    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > Blackjack::BLACKJACK_AMOUNT
  end
end

class Player
  include Hand

  attr_accessor :cards, :name

  def initialize(name)
    @name = name
    @cards = []
  end

  def show_flop
    show_hand
  end
end

class Dealer
  include Hand

  attr_accessor :cards, :name

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
    puts "Dealer's hand:"
    puts "---> first card is hidden"
    puts "---> second card is #{cards[1]}"
  end
end

class Blackjack
  attr_accessor :deck, :player, :dealer

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    @deck = Deck.new
    @player = Player.new('Player1')
    @dealer = Dealer.new
  end

  def set_player_name
    puts "What's your name?"
    player.name = gets.chomp
  end

  def deal_cards
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def blackjack_or_bust?(player_or_dealer)
    if player_or_dealer.total == BLACKJACK_AMOUNT
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, dealer hit blackjack. #{player.name} loses."
      else
        puts "Congrats, #{player.name} hit blackjack! #{player.name} Wins!!!"
      end
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "Congrats, dealer busted. #{player.name} wins!!"
      else
        puts "Sorry, #{player.name} busted. #{player.name} loses"
      end
      play_again?
    end
  end

  def player_turn
    puts "#{player.name}'s turn"

    blackjack_or_bust?(player)

    while !player.is_busted?
      puts "What would you like to do? 1) hit 2) stay"
      response = gets.chomp

      if !['1', '2'].include?(response)
        puts "Error: you must enter 1 or 2"
        next
      end


      if response == '2'
        puts "#{player.name} chose to stay"
        break
      end

      new_card = deck.deal_one
      puts "Dealing card to #{player.name}: #{new_card}"
      player.add_card(new_card)
      puts "#{player.name}'s total is now: #{player.total}"

      blackjack_or_bust?(player)
    end
    puts "#{player.name} stays at #{player.total}"
  end

  def dealer_turn
    puts "Dealer's turn."

    blackjack_or_bust?(dealer)

    while dealer.total < DEALER_HIT_MIN
      new_card = deck.deal_one
      puts "Dealing card to dealer: #{new_card}"
      dealer.add_card(new_card)
      puts "Dealer total is now: #{dealer.total}"

      blackjack_or_bust?(dealer)
    end
    puts "Dealer stays at #{dealer.total}."
  end

  def who_won?
    if player.total > dealer.total
      puts "Congrats! #{player.name} wins!!"
    elsif player.total < dealer.total
      puts "Sorry, #{player.name} loses."
    else
      puts "Its a tie!"
    end
    play_again?
  end

  def play_again?
    puts ""
    puts "Would you like to play again? 1) yes 2) no, exit"
    if gets.chomp == '1'
      puts "Starting new game..."
      puts ""
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      start
    else
      puts "Goodbye"
      exit
    end
  end


  def start
    set_player_name
    deal_cards
    show_flop
    player_turn
    dealer_turn
    who_won?
  end
end



game = Blackjack.new
game.start














