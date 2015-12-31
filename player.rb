$FOLDER = File.dirname(__FILE__)

class Player
	attr_reader :x
	attr_accessor :y
	def initialize(update_interval)
		@image = Gosu::Image.new($FOLDER+"/media/starfighter.bmp")
		@x_speed = @y_speed = @x = @y = @angle = 0.0
		@interval = update_interval/1000.0
	end

	def warp(x, y)
		@x_middle, @y_middle = x-@image.width/2, y-@image.height/2
		end

	def run_left
		@x_speed = -150
	end

	def run_right
		@x_speed = 150
	end
	
	def stop_x
		@x_speed = 0
	end

	def stop_y
		@y_speed = 0
	end
	
	def land(y)
		@y = y
		@is_on_ground = true
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
		
		if !@is_on_ground then
			@y_speed -= 50
		end
	end

	def draw
		@image.draw(@x_middle, @y_middle, 1)
	end
end
