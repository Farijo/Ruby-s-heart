class World
	def initialize
		@entities = []
	end
	
	def collisions(player)
		
	end
	
	def update
		@entities.each { |a| a.update }
	end

	def draw
		@entities.each { |a| a.update }
	end
end
