#!/usr/bin/ruby

module Attack
	def try_hit(hit_chance)
		return rand(100) > hit_chance ? true : false
		#returns true if the random number is above the hit_chance and false if not
	end

	def damage(damage_modifier, dice)
		return rand(dice) * damage_modifier
		#rolls the dice, multiplies the modifier and returns the damage
	end
end

class Weapon
	include Attack #enables me to use the methods within Attack
	attr_accessor :name #name of weapon
	attr_accessor :hit_chance #holds bar for minimum roll to recieve a hit
	attr_accessor :damage_modifier #holds the multiplier used with the dice
	attr_accessor :dice #holds the size of the "dice" based on the weapon

	def initialize(name, hit_chance, damage_modifier, dice)
		@name, @hit_chance, @damage_modifier, @dice = name, hit_chance, damage_modifier, dice
	end

	def swing
		return try_hit(@hit_chance) ? damage(@damage_modifier, @dice) : 0
		#returns returns damage if a hit occurs, 0 if not
	end
end	
