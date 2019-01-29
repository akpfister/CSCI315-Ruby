#!/usr/bin/ruby

module Attack
	def try_hit()
			# Your code here!
	end

	def damage()
			# Your code here!
	end
end

class Weapon
	include Attack #enables you to use the methods within Attack

	def initialize()
			# Your code here!
	end

	def swing
			# Your code here!
	end
end
