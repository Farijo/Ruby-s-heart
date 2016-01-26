$FOLDER = File.dirname(__FILE__)

require $FOLDER+'/data_const.rb'

class World
	def initialize
		@ground_tiles = Gosu::Image::load_tiles($FOLDER+"/media/ground.png", GROUND_TILES_SIZE, GROUND_TILES_SIZE, :tileable => true)
		@entities = Array.new
		@ground = Array.new
		
		level = File.open($FOLDER+"/level_1.rsh", "r")
		
		level.each_line { |line|
			line_array = line.split(//)
			u = Array.new
			line_array.each { |char|
				u << [@ground.size*GROUND_TILES_SIZE,u.size*GROUND_TILES_SIZE,rand(@ground_tiles.size)] if char == "1"
				u << [@ground.size*GROUND_TILES_SIZE,u.size*GROUND_TILES_SIZE,@ground_tiles.size] if char == "0"
			}
			@ground << u
		}
		
		level.close
	end
	
	def collisions(player)
		
		right = (player.x+GROUND_TILES_HALF_SIZE)+GROUND_TILES_SIZE-(player.x+GROUND_TILES_HALF_SIZE)%GROUND_TILES_SIZE
		bot = (player.y+GROUND_TILES_HALF_SIZE)+GROUND_TILES_SIZE-(player.y+GROUND_TILES_HALF_SIZE)%GROUND_TILES_SIZE
		
		droite = right/GROUND_TILES_SIZE-1
		bas = bot/GROUND_TILES_SIZE-1
		haut = bas-1
		gauche = droite-1
		
		intersec_x = right-GROUND_TILES_SIZE
		intersec_y = bot-GROUND_TILES_SIZE
		
		b_gauche = true
		b_droite = true
		b_bas_gauche = true
		b_bas_droite = true
		
		if haut<0 or haut>=@ground[0].size then
			b_gauche = false
			b_droite = false
		else
			if gauche<0 or gauche>=@ground.size then
				b_gauche = false
			else
				b_gauche = @ground[gauche][haut][2]!=@ground_tiles.size
			end
			if droite<0 or droite>=@ground.size then
				b_droite = false
			else
				b_droite = @ground[droite][haut][2]!=@ground_tiles.size
			end
		end
		
		if bas<0 or bas>=@ground[0].size then
			b_bas_gauche = false
			b_bas_droite = false
		else
			if gauche<0 or gauche>=@ground.size then
				b_bas_gauche = false
			else
				b_bas_gauche = @ground[gauche][bas][2]!=@ground_tiles.size
			end
			if droite<0 or droite>=@ground.size then
				b_bas_droite = false
			else
				b_bas_droite = @ground[droite][bas][2]!=@ground_tiles.size
			end
		end
		
		code = 0
		code += 1 if b_gauche
		code += 2 if b_droite
		code += 4 if b_bas_gauche
		code += 8 if b_bas_droite
		
		case code
		when 0
			player.fall
		when 1
			if (intersec_x - player.x) <= (intersec_y - player.y) then
				player.fall
				player.hit_side_left(intersec_x)
			else
				player.hit_side_top(intersec_y)
			end
		when 2
			if (player.x - intersec_x) <= (intersec_y - player.y) then
				player.fall
				player.hit_side_right(intersec_x)
			else
				player.hit_side_top(intersec_y)
			end
		when 3
			player.hit_side_top(intersec_y)
		when 4
			if (intersec_x - player.x) <= (player.y - intersec_y) then
				player.fall
				player.hit_side_left(intersec_x)
			else
				player.land(intersec_y)
			end
		when 5
			player.fall
			player.hit_side_left(intersec_x)
		when 6
			if player.x <= intersec_x and player.y <= intersec_y then
				player.hit_side_right(intersec_x)
				player.land(intersec_y)
			else
				if player.x >= intersec_x and player.y >= intersec_y then
					player.hit_side_top(intersec_y)
					player.hit_side_left(intersec_x)
				end
			end
		when 7
			player.hit_side_top(intersec_y)
			player.hit_side_left(intersec_x)
		when 8
			if (player.x - intersec_x) <= (player.y - intersec_y) then
				player.fall
				player.hit_side_right(intersec_x)
			else
				player.land(intersec_y)
			end
		when 9
			if player.x >= intersec_x and player.y <= intersec_y then
				player.hit_side_left(intersec_x)
				player.land(intersec_y)
			else
				if player.x <= intersec_x and player.y >= intersec_y then
					player.hit_side_top(intersec_y)
					player.hit_side_right(intersec_x)
				end
			end
		when 10
			player.fall
			player.hit_side_right(intersec_x)
		when 11
			player.hit_side_top(intersec_y)
			player.hit_side_right(intersec_x)
		when 12
			player.land(intersec_y)
		when 13
			player.hit_side_left(intersec_x)
			player.land(intersec_y)
		when 14
			player.hit_side_right(intersec_x)
			player.land(intersec_y)
		when 15
			exit
		end
	end
	
	def update
		@entities.each { |a| a.update }
	end

	def draw(x, y, mid_x, mid_y)
		@ground.each { |line| line.each { |data| @ground_tiles[data[2]].draw(data[0]-x+mid_x, data[1]-y+mid_y, 0) if data[2]!=@ground_tiles.size } }
		
		@entities.each { |a| a.draw }
	end
end
