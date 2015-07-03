#Deck of 52 Cards 4 suits

#Player places bet
#Deal one card face up to player
#Deal one card to computer face up
#Deal one card to player face up
#Deal one card to computer face down
#Player checks for Blackjack
#computer checks for Blackjack

# it's not blackjack 
#is it a soft hand? (ace with non 10 card)
#player stands or player hits
#check for player bust

#Display 2nd dealer card 

#if dealer has 17 
#  dealer stands
#else
#  is it a soft hand
#  dealer hits until he has 17 or higher or bust

#  Player hits or stands
require 'pry'

def draw_card(drawn_cards)
  random_card = [CARDS.sample, SUIT.sample]
    if !drawn_cards.key?(random_card[0])
      drawn_cards[random_card[0]] = [random_card[1]]
      drawn_card = random_card
    elsif !drawn_cards[random_card[0]].include?(random_card[1])
      drawn_cards[random_card[0]].push(random_card[1])
      drawn_card = random_card
    elsif drawn_cards.size == CARDS.count  && drawn_cards.values.flatten.count == COUNT  
      return
    else
     draw_card(drawn_cards)
    end  
end

def add_card(hand,drawn_cards)
  hand << draw_card(drawn_cards)
end

def calculate_hand(hand)
  value = 0
  hand.each do |count|
    value += count[0] if count[0].class == Fixnum
    value +=10 if count.include?("QUEEN")
    value +=10 if count.include?("KING")
    value +=10 if count.include?("JACK")
    value +=11 if count.include?("ACE") 
    end
  hand.select {|number,suit| number == "ACE"}.count.times do
    value -= 10 if value > 21
  end
   value
end

def player_bust(total)
  if total == 21
    status = "Blackjack"
  elsif total > 21
    status = "Bust"

  end
    

end

def print_player_hand(player_hand,p_total)

    player_hand.each do |value,suit|
    puts value.to_s + " of " + suit.to_s
  end
    puts "for a total of #{p_total}"
    puts ""
end

def black_jack(p_total,c_total)
  if p_total == 21
    puts "Player Wins!"
    winner = 'Player'
    
  elsif c_total == 21
    puts "Dealer wins! with #{c_total}"
    winner = 'Dealer'
    
  end
end


    #Clear the table, start a new game or quit.
CARDS = [2,3,4,5,6,7,8,9,10,'JACK','QUEEN','KING','ACE']
SUIT = ['HEARTS', 'DIAMONDS', 'SPADES', 'CLUBS']
FACE_CARDS = ['JACK','QUEEN','KING']
COUNT = 52

player_status = ' '
while player_status != 'n' do
card_count = 0
my_deck = {}
player_hand = []
computer_hand = []
game_over = false

while !game_over


add_card(player_hand,my_deck)
add_card(computer_hand,my_deck)
add_card(player_hand,my_deck)
player_total = calculate_hand(player_hand)
add_card(computer_hand,my_deck)
computer_total = calculate_hand(computer_hand)
puts "Player hand is "
print_player_hand(player_hand,player_total)

  
puts "computer hand is " #+ "#{computer_hand.first} " + " and face down card"
puts computer_hand[0][0].to_s.gsub(/\s|"|'/, '') + " of " + computer_hand[0][1].to_s.gsub(/\s|"|'/, '')

loop do
  if player_total == 21 
    break
  end
  puts "Hit(h) or Stand(s): "
  player_action = gets.chomp.downcase
  if player_action == 'h'
    add_card(player_hand,my_deck)
    player_total = calculate_hand(player_hand)
    status = player_bust(player_total)
    puts "Player hand is "
    print_player_hand(player_hand,player_total)
    if status == 'Bust'
      game_over = true
      break
    end
  end
  break if player_action == 's'
  end
#binding.pry
if player_total > 21
  puts "Player busted with "
  print_player_hand(player_hand,player_total)
  break
else
  puts "computer hand is "
  print_player_hand(computer_hand,computer_total)
while calculate_hand(computer_hand) < 17 do  
    add_card(computer_hand,my_deck)
    computer_total = calculate_hand(computer_hand)
end
end
if player_bust(computer_total) == 'Bust'
  puts "Dealer busted with "
  print_player_hand(computer_hand,computer_total)
  p "Computer total: #{computer_total}, Player wins!"
  game_over = true
elsif player_total > computer_total
  puts "Player wins with "
  print_player_hand(player_hand,player_total)
  p "with Player Total:#{player_total} over Computer Total: #{computer_total}"
  game_over = true
elsif player_total == computer_total
  puts "Player ties with dealer!"
  print_player_hand(computer_hand,computer_total)
  game_over = true
elsif player_bust(computer_total)  == 'Blackjack'  || player_total < computer_total
  puts "Computer hand "
  print_player_hand(computer_hand,computer_total)
  puts "Dealer wins with #{computer_total}"
  game_over = true
end
end

puts "Do you want to play again? (y/n): "
player_status = gets.chomp.downcase
end

  
