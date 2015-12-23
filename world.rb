class World
	def initialize
		@entities = []
	end
	
	def collisions(player)
	print player.y,"\n"
		if player.y < 400
			player.stop_y
			player.y = 401
		end
	end
	
	def update
		@entities.each { |a| a.update }
	end

	def draw
		@entities.each { |a| a.update }
	end
end
