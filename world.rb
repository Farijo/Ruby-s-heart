$FOLDER = File.dirname(__FILE__)

class World
	def initialize
		@square_size = 50
		@square_size2 = @square_size/2
		@ground_tiles = Gosu::Image::load_tiles($FOLDER+"/media/ground.png", @square_size, @square_size, :tileable => true)
		@entities = Array.new
		@ground = Array.new
		
		for i in 0..13
			u = Array.new
			for j in 0..10
				u << [i*@square_size,j*@square_size,rand(@ground_tiles.size+1)]
			end
			@ground << u
		end
	end
	
	def collisions(player)
		#@ground[player.x/50].each { |data| if player.y_down>=data[1] and data[2]!=@ground_tiles.size then player.land(data[1]); break end }
		
		@ground.each { |line| line.each { |data|	next if data[2]==@ground_tiles.size
													x_diff = data[0]+@square_size2-player.x
													y_diff = data[1]+@square_size2-player.y
													
													if y_diff.abs <= @square_size and x_diff.abs <= @square_size then
														if 0<y_diff and y_diff<=@square_size then
															player.land(data[1])
															next
														else
															if -@square_size<=y_diff and y_diff<0 then
																player.stop_y
																next
															end
														end
														if 0<x_diff and x_diff<=@square_size then
															player.hit_side_right(data[0])
														else
															if -@square_size<=x_diff and x_diff<0 then
																player.hit_side_left(data[0]+@square_size)
															end
														end
													end } }
	end
	
	def update
		@entities.each { |a| a.update }
	end

	def draw(x, y, mid_x, mid_y)
		@ground.each { |line| line.each { |data| @ground_tiles[data[2]].draw(data[0]-x+mid_x, data[1]-y+mid_y, 0) if data[2]!=@ground_tiles.size } }
		
		@entities.each { |a| a.draw }
	end
end
