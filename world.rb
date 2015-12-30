$FOLDER = File.dirname(__FILE__)

class World
	def initialize
		@ground_tiles = Gosu::Image::load_tiles($FOLDER+"/media/ground.png", 50, 50, :tileable => true)
		@entities = Array.new
		@ground = Array.new
		
		for i in 0..13
			u = Array.new
			for j in 0..10
				u << [i*50,j*50,rand(@ground_tiles.size+1)]
			end
			u.delete_if { |data| data[2]==@ground_tiles.size }
			@ground << u
		end
	end
	
	def collisions(player)
		
	end
	
	def update
		@entities.each { |a| a.update }
	end

	def draw(x, y)
	print @ground[0][0][0]-x," ",@ground[0][0][1]-y,"\n"
		@ground.each { |line| line.each { |data| @ground_tiles[data[2]].draw(data[0]-x, data[1]-y, 0) } }
		
		@entities.each { |a| a.update }
	end
end
