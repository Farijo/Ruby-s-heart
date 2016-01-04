$FOLDER = File.dirname(__FILE__)

class Player
	attr_reader :x, :y
	def initialize(update_interval)
		@image = Gosu::Image.new($FOLDER+"/media/starfighter.bmp")
		@image_half_width = @image.width/2
		@image_half_height = @image.height/2
		@x_speed = @y_speed = @x = @y = 0
		@x = 100
		@interval = update_interval/1000.0
		@is_on_ground = false
	end

	def warp(x, y)
		@x_middle, @y_middle = x-@image.width/2, y-@image.height/2
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

	def stop_y
		@y_speed = 0
	end
	
	def is_falling
		return !@is_on_ground
	end
	
	def fall
		@is_on_ground = false
	end
	
	def land(y)
		@y = y-@image_half_height
		@y_speed = 0
		@is_on_ground = true
	end
	
	def hit_side_left(x)
		@x = x+@image_half_width
	end
	
	def hit_side_right(x)
		@x = x-@image_half_width
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
		
		if @x < 0 then
			@x = 0
		end
		
		@y_speed -= 40 if !@is_on_ground
	end

	def draw
		@image.draw(@x_middle, @y_middle, 1)
	end
end
