#!/usr/bin/ruby

require_relative 'player'
require 'catpix'

puts "Welcome to D&D Dice Roller!"

	Catpix::print_image "dice.jpg",
		  :limit_x => 0.5,
		  :limit_y => 0,
		  :center_x => true,
		  :center_y => true,
		  :bg => "white",
		  :bg_fill => false,
		  :resolution => "high"
	#prints the dice picture at the beginning of the game

#------------------------------------------------------------
puts "Please enter Machine weapon set."

m_list = [] #Machine weapon list
i = 0
while i < 3
	puts "Name of weapon:"
	str = gets.chomp
	puts "Hit chance for #{str}:"
	hc = gets.chomp.to_i
	puts "Damage modifier for #{str}:"
	dm = gets.chomp.to_i
	puts "Dice size for #{str}:"
	dice = gets.chomp.to_i
	m_list.push(Weapon.new(str, hc, dm, dice))
	puts "#{str} has been added to Machine weapon set."
	i += 1
end
#here I am taking in the Machine weapon set, and it is hardcoded to take 3 weapons

#------------------------------------------------------------
puts "Please enter Human weapon set."

h_list = [] #Human weapon list
i = 0
while i < 3
	puts "Name of weapon:"
	str = gets.chomp
	hc = gets.chomp.to_i
	puts "Hit chance for #{str}:"
	dm = gets.chomp.to_i
	puts "Dice size for #{str}:"
	dice = gets.chomp.to_i
	h_list.push(Weapon.new(str, hc, dm, dice))
	puts "#{str} has been added to Human weapon set."
	i += 1
end
#here I am taking in the Human weapon set, and it is hardcoded to take 3 weapons

#------------------------------------------------------------
puts "Enter starting health for the players."

player_health = gets.chomp.to_i

#------------------------------------------------------------
puts "Please enter name of Player One (Machine if machine)."

name = gets.chomp
if name == "Machine"
	player1 = Machine.new(player_health, m_list)
else
	player1 = Human.new(player_health, h_list, name)
end

#------------------------------------------------------------
puts "Please enter name of Player Two (Machine if machine)."

name = gets.chomp
if name == "Machine"
	player2 = Machine.new(player_health, m_list)
	if player1.name == "Machine"
		player2.name = "Machine2"
		# reset this Machines name for clarification in Tests 5
	end
else
	player2 = Human.new(player_health, h_list, name)
end

#------------------------------------------------------------
puts "How many rounds would you like to play?"

num_rounds = gets.chomp.to_i
puts "\n"

#------------------------------------------------------------

outcome = [] #list for printing a summary of each round at end of game
round_num = 1
while round_num <= num_rounds
	puts "ROUND #{round_num} of #{num_rounds}:\n"

	player1.set_weapon 
	player2.set_weapon
	#set_weapon automatically picks a weapon (Machine) or prompts the Human for their choice

	puts "#{player1.name}s weapon is the #{player1.weapon.name}."
	puts "#{player2.name}s weapon is the #{player2.weapon.name}.\n"

	Catpix::print_image "fight.png",
		  :limit_x => 0.5,
		  :limit_y => 0,
		  :center_x => true,
		  :center_y => true,
		  :bg => "white",
		  :bg_fill => false,
		  :resolution => "high"
	#prints out the "Fight" image to signify the beginning of a round
 
	while player1.health > 0 and player2.health > 0
		p1 = player1.weapon.swing
		p2 = player2.weapon.swing
		#first record the outcome of the swing by each play
		#these values are then used to determine the playout of the round

		if p1 > 0
			if player2.health - p1 > 0
				player2.health = player2.health - p1
				puts "#{player1.name} swung and hit for #{p1} points of damage.\n #{player2.name}s health is now #{player2.health}.\n"
			else 
				puts "#{player1.name} swung and hit for #{p1} points of damage.\n #{player2.name} has died.\n"
				player1.wins += 1
				outcome.push("#{player1.name} won round #{round_num} using a #{player1.weapon.name}.")
				break
			end
		else
			puts "#{player1.name} has missed."
		end
	
		if p2 > 0
			if player1.health - p2 > 0
				player1.health = player1.health - p2
				puts "#{player2.name} swung and hit for #{p2} points of damage.\n #{player1.name}s health is now #{player1.health}.\n"
			else 
				puts "#{player2.name} swung and hit for #{p2} points of damage.\n #{player1.name} has died.\n"
				player2.wins += 1
				outcome.push("#{player2.name} won round #{round_num} using a #{player2.weapon.name}.")
				break
			end
		else
			puts "#{player2.name} has missed."
		end

		#check p1 first to keep the "turn" style of the game
		#All of Player 1s actions should be calculated before moving on the Player 2
	end

	player1.health = player_health
	player2.health = player_health
	round_num += 1
	#resets Players health and increments round	

	puts "\n"
end

for e in outcome
	puts e
end
#loop for printing summary of each round
puts "\n"

if player1.wins > player2.wins
	puts "#{player1.name} was .."
	Catpix::print_image "memedice.png",
		  :limit_x => 0.5,
		  :limit_y => 0,
		  :center_x => true,
		  :center_y => true,
		  :bg => "white",
		  :bg_fill => false,
		  :resolution => "high"
	puts "and won the game."
else
	puts "#{player2.name} was .."
	Catpix::print_image "memedice.png",
		  :limit_x => 0.5,
		  :limit_y => 0,
		  :center_x => true,
		  :center_y => true,
		  :bg => "white",
		  :bg_fill => false,
		  :resolution => "high"
	puts "and won the game."
end
#prints meme for each player, regardless if Machine or Human
