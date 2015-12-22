require 'gosu'

load 'player.rb'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"
	
    @background_image = Gosu::Image.new("media/space.png", :tileable => true)
	@ground = Gosu::Image.new("media/ground.png", :tileable => true)
	@list = []
	for i in 0..100
		@list.push(i*100)
		@list.push(@ground)
	end

    @player = Player.new
    @player.warp(320, 240)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
      @player.turn_right
    end
    if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player.move
  end

  def draw
    @player.draw(640/2,480/2)
    @background_image.draw(0, 0, 0)
	$i = 0
	$num = @list.size
	begin
		@list[$i+1].draw(@list[$i]-@player.x,480-@player.y,0)
		$i += 2;
	end while $i < $num
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
