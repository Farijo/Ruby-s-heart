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
	end

	def button_down(id)
		
	end
	
	def needs_cursor?
		true
	end
end

GameWindow.new.show
