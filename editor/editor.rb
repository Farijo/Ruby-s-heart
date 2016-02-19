require 'gosu'
include Gosu

$FOLDER = File.dirname(__FILE__) + "/"

class GameWindow < Gosu::Window
	def initialize
		super 500,500
	end

	def update
		
	end

	def draw
		for i in 0..100
			for j in 0..100
				draw_line(i*50,j*50,Color::GRAY,i*50+50,j*50,Color::GRAY)
				draw_line(i*50+50,j*50,Color::GRAY,i*50+50,j*50+50,Color::GRAY)
				draw_line(i*50+50,j*50+50,Color::GRAY,i*50,j*50+50,Color::GRAY)
				draw_line(i*50,j*50+50,Color::GRAY,i*50,j*50,Color::GRAY)
			end
		end
		
		x = (mouse_x/50).to_i
		y = (mouse_y/50).to_i
		
		draw_rect(x*50, y*50+1, 49, 49, Color::RED)
	end

	def button_down(id)
		if id == Gosu::KbEscape then
			close
		end
	end
	
	def needs_cursor?
		true
	end
end

GameWindow.new.show
