$FOLDER = File.dirname(__FILE__) + "/"

require $FOLDER+'data_const.rb'

class Player
	attr_reader :x, :y
	
	def initialize(update_interval)
		@image = Gosu::Image.new($FOLDER+"media/starfighter.bmp")
		if (@image.height != PLAYER_SIZE) or (@image.height != PLAYER_SIZE) then
			print "character bad size\n"
			exit
		end
		@x_speed = @y_speed = @x = @y = 0
		@interval = update_interval/1000.0
		@is_on_ground = false
	end

	def warp(x, y)
		@x_middle, @y_middle = x-@image.width/2, y-@image.height/2
	end
	
	def start_position(x, y)
		@x, @y = x, y
	end
	
	def run_left
		@x_speed = -200
	end

	def run_right
		@x_speed = 200
	end
	
	def stop_x
		@x_speed = 0
	end
	
	def fall
		@is_on_ground = false
	end
	
	def land(y)
		@y = y - PLAYER_HALF_SIZE
		@y_speed = 0
		@is_on_ground = true
	end
	
	def hit_side_top(y)
		@y = y + PLAYER_HALF_SIZE
		@y_speed = 0
		@is_on_ground = false
	end
	
	def hit_side_left(x)
		@x = x + PLAYER_HALF_SIZE
	end
	
	def hit_side_right(x)
		@x = x - PLAYER_HALF_SIZE
	end
	
	def jump
		if @is_on_ground then
			@y_speed = 800
			@is_on_ground = false
		end
	end

	def move
		@y -= (@y_speed * @interval).to_i
		@x += (@x_speed * @interval).to_i
		
		@y_speed -= 40 if !@is_on_ground
	end

	def draw
		@image.draw(@x_middle, @y_middle, 1)
	end
end
