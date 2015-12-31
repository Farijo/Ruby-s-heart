$FOLDER = File.dirname(__FILE__)

class Player
	attr_reader :x, :y, :x_left, :x_right, :y_up, :y_down
	def initialize(update_interval)
		@image = Gosu::Image.new($FOLDER+"/media/starfighter.bmp")
		@image_half_width = @image.width/2
		@image_half_height = @image.height/2
		@x_speed = @y_speed = @x = @y = @angle = 0.0
		self.update_border
		@interval = update_interval/1000.0
	end

	def warp(x, y)
		@x_middle, @y_middle = x-@image.width/2, y-@image.height/2
	end

	def update_border
		@x_left = @x-@image_half_width
		@x_right = @x+@image_half_width
		@y_up = @y-@image_half_height
		@y_down = @y+@image_half_height
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
	
	def land(y)
		@y = y-@image_half_height
		@y_speed = 0
		@is_on_ground = true
	end
	
	def hit_side(x)
		@x = x
	end
	
	def jump
		if @is_on_ground then
			@y_speed = 800
			@is_on_ground = false
		end
	end

	def move
		@y -= @y_speed * @interval
		@x += @x_speed * @interval
		
		if @x < 0.0 then
			@x = 0.0
		end
		
		@y_speed -= 40
		
		self.update_border
	end

	def draw
		@image.draw(@x_middle, @y_middle, 1)
	end
end
