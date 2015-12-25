class Player
	attr_reader :x
	attr_accessor :y
	def initialize
		@image = Gosu::Image.new("media/starfighter.bmp")
		@x_speed = @y_speed = @x = @y = @angle = 0.0
	end

	def warp(x, y)
		@x, @y = x, y
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
	
	def jump
		if @is_on_ground then
			@y_speed = 800
			@is_on_ground = false
		end
	end

	def move(update_interval)
		@y -= @y_speed * (update_interval/1000.0)
		@x += @x_speed * (update_interval/1000.0)
		
		if @y > 480 then
			@y = 480
			@is_on_ground = true
		end
		
		@y_speed -= 50
		
		@x %= 640
		# @y %= 480
	end

	def draw(p_x,p_y)
		@image.draw_rot(@x, @y, 1, @angle)
	end
end
