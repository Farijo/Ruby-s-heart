require 'gosu'

$FOLDER = File.dirname(__FILE__) + "/"

require $FOLDER+'world.rb'
require $FOLDER+'player.rb'

class GameWindow < Gosu::Window
	def initialize
		@half_width = 640
		@half_height = 480
		super @half_width*2, @half_height*2
		self.caption = "Ruby's heart"
		
		@background_image = Gosu::Image.new($FOLDER+"media/space.png", :tileable => true)
		@background_x = 0;
		@background_y = 0;
		@UI_image = Gosu::Image.new($FOLDER+"media/UI_element_whitefill_large.png", :tileable => true)
		
		@player = Player.new(self.update_interval)
		@player.warp(@half_width, @half_height)
		
		@world = World.new
		
		@player.start_position(@world.start_x, @world.start_y)
	end

	def update
		@player.run_right if Gosu::button_down? Gosu::KbRight
		@player.run_left if Gosu::button_down? Gosu::KbLeft
		@player.stop_x if !Gosu::button_down? Gosu::KbLeft and !Gosu::button_down? Gosu::KbRight
		
		@player.move
		@world.update
		@world.collisions(@player)
	end

	def draw
		@background_x += (Random.new_seed%3)-1
		@background_y += (Random.new_seed%3)-1
		@background_x += 1 if @background_x < -10
		@background_x -= 1 if @background_x > 10
		@background_y += 1 if @background_y < -10
		@background_y -= 1 if @background_y > 10
		@background_image.draw(@background_x, @background_y, 0)
		@player.draw
		@world.draw(@player.x, @player.y, @half_width, @half_height)
		@UI_image.draw(0, 0, 2)
	end

	def button_down(id)
		if id == Gosu::KbEscape then
			close
		else
			if id== Gosu::KbSpace then
				@player.jump
			end
		end
	end
	
	def needs_cursor?
		true
	end
end

GameWindow.new.show
