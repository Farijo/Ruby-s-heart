class Player
	attr_reader :x
	attr_reader :y
	def initialize
		@image = Gosu::Image.new("media/starfighter.bmp")
		@y_speed = @x = @y = @angle = 0.0
		@score = 0
	end

	def warp(x, y)
		@x, @y = x, y
		end

	def run_left
		@x -= 4
	end

	def run_right
		@x += 4
	end

	def jump
		if @is_on_ground then
			@y_speed = 800
			@is_on_ground = false
		end
	end

	def move(update_interval)
		@y -= @y_speed * (update_interval/1000.0)
		@y_speed -= 50
		
		if @y > 480-@image.height/2 then
			@y = 480-@image.height/2
			@is_on_ground = true
		end
		
		@x %= 640
	end

	def draw(p_x,p_y)
		@image.draw_rot(@x, @y, 1, @angle)
	end
end
