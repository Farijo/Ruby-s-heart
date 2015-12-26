require 'gosu'

load 'world.rb'
load 'player.rb'

class GameWindow < Gosu::Window
	def initialize
		@half_width = 320
		@half_height = 240
		super @half_width*2, @half_height*2
		self.caption = "Ruby's heart"
		
		@background_image = Gosu::Image.new("media/space.png", :tileable => true)
		
		@player = Player.new
		@player.warp(@half_width, @half_height)
		
		@world = World.new
	end

	def update    
		if Gosu::button_down? Gosu::KbLeft then
		  @player.run_left
		end
		if Gosu::button_down? Gosu::KbRight then
		  @player.run_right
		end
		if !(Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::KbRight) then
		  @player.stop_x
		end
		if Gosu::button_down? Gosu::KbSpace then
		  @player.jump
		end
		
		@world.collisions(@player)
		@world.update
		@player.move(self.update_interval)
	end

	def draw
		@background_image.draw(0, 0, 0)
		@player.draw(@half_width, @half_height)
		@world.draw
	end

	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
	end
  
	def needs_cursor?
		true
	end
end

GameWindow.new.show
