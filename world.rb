class World
	def initialize
		@entities = []
	end
	
	def update
		@entities.each { |a| a.update }
	end

	def draw
		@entities.each { |a| a.update }
	end
end
