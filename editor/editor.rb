require 'gosu'
include Gosu

$FOLDER = File.dirname(__FILE__) + "/"

class GameWindow < Gosu::Window
	def initialize
		super 500,500
		@numTile = 15
	end

	def update
		
	end

	def draw
		numX = width*(mouse_x*@numTile/width).to_i
		numY = height*(mouse_y*@numTile/height).to_i
		xX = numX/@numTile
		yY = numY/@numTile
		xX2 = (width+numX)/@numTile
		yY2 = (height+numY)/@numTile
		draw_rect(xX, yY, xX2-xX, yY2-yY,Color::RED)
		
		for i in 0..@numTile
			posX = i*width
			posY = i*height
			draw_line(0,posY/@numTile,Color::GRAY,width,posY/@numTile,Color::GRAY)
			draw_line(posX/@numTile,0,Color::GRAY,posX/@numTile,height,Color::GRAY)
		end
		draw_line(0,height-1,Color::GRAY,width,height-1,Color::GRAY)
		draw_line(1,0,Color::GRAY,1,height,Color::GRAY)
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

