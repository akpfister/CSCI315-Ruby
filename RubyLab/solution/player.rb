#!/usr/bin/ruby

require_relative 'weapon'

class Player
	attr_accessor :health #health of the player
	attr_accessor :wins #number of wins of the player
	# @weapons_list is the array of weapons to choose from

	def initialize(health, weapons_list)
		@health, @weapons_list, @wins = health, weapons_list, 0
	end
end

class Human < Player
	attr_accessor :weapon #current weapon of the player
	attr_accessor :name #name of the player

	def initialize(health, weapons_list, name)
		super(health, weapons_list) #sets variables of inherited class
		@name = name
	end

	def set_weapon
		puts "Pick a weapon: #{@weapons_list[0].name}(0), #{@weapons_list[1].name}(1), #{@weapons_list[2].name}(2)" 
		#0, 1 or 2 because weapons stored in a list

		option = gets.to_i 
		#gets input and converts it to an integer

		@weapon = @weapons_list[option]
		#prompts the player to pick their weapon
	end
end 

class Machine < Player
	attr_accessor :weapon #current weapon of the machine
	attr_accessor :name #"Machine"

	def initialize(health, weapons_list)
		super(health, weapons_list) 
		@weapon, @name = @weapons_list[rand(3) - 1], "Machine"
	end

	def set_weapon
		@weapon = @weapons_list[rand(3) - 1]
		#randomly selects a weapon for the Machine
	end
end 
