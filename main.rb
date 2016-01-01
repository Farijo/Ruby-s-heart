require 'gosu'

$FOLDER = File.dirname(__FILE__)

require $FOLDER+'/world.rb'
require $FOLDER+'/player.rb'

class GameWindow < Gosu::Window
	def initialize
		@half_width = 320
		@half_height = 240
		super @half_width*2, @half_height*2
		self.caption = "Ruby's heart"
		
		@background_image = Gosu::Image.new($FOLDER+"/media/space.png", :tileable => true)
		
		@player = Player.new(self.update_interval)
		@player.warp(@half_width, @half_height)
		
		@world = World.new
	end

	def update
		@player.run_right if Gosu::button_down? Gosu::KbRight
		@player.run_left if Gosu::button_down? Gosu::KbLeft
		@player.stop_x if !Gosu::button_down? Gosu::KbLeft and !Gosu::button_down? Gosu::KbRight
		
		@player.move
		@world.update
		@world.collisions(@player)
		
		print @player.x," ",@player.y,"\n"
	end

	def draw
		@background_image.draw(0, 0, 0)
		@player.draw
		@world.draw(@player.x, @player.y, @half_width, @half_height)
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
