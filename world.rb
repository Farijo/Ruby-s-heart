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
			@ground << u
		end
	end
	
	def collisions(player)
		@ground[player.x/50].each { |data| if player.y>data[1] and data[2]!=@ground_tiles.size then player.land(data[1]); break end }
	end
	
	def update
		@entities.each { |a| a.update }
	end

	def draw(x, y, mid_x, mid_y)
		@ground.each { |line| line.each { |data| @ground_tiles[data[2]].draw(data[0]-x+mid_x, data[1]-y+mid_y, 0) if data[2]!=@ground_tiles.size } }
		
		@entities.each { |a| a.draw }
	end
end
