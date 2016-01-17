$FOLDER = File.dirname(__FILE__)

class World
	def initialize
		@square_size = 50
		@square_size2 = @square_size/2
		@ground_tiles = Gosu::Image::load_tiles($FOLDER+"/media/ground.png", @square_size, @square_size, :tileable => true)
		@entities = Array.new
		@ground = Array.new
		
		for i in 0..13
			u = Array.new
			for j in 0..10
				u << [i*@square_size,j*@square_size,rand(@ground_tiles.size+1)]
			end
			@ground << u
		end
	end
	
	def collisions(player)
		
		right = (player.x+25)+50-(player.x+25)%50
		bot = (player.y+25)+50-(player.y+25)%50
		
		droite = right/50-1
		bas = bot/50-1
		haut = bas-1
		gauche = droite-1
		
		intersec_x = right-50
		intersec_y = bot-50
		
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
			if (player.x - intersec_x).abs < (player.y - intersec_y).abs then
				player.hit_side_top(intersec_y)
			else
				player.fall
				player.hit_side_left(intersec_x)
			end
		when 2
			if (player.x - intersec_x).abs < (player.y - intersec_y).abs then
				player.hit_side_top(intersec_y)
			else
				player.fall
				player.hit_side_right(intersec_x)
			end
		when 3
			player.hit_side_top(intersec_y)
		when 4
			if (player.x - intersec_x).abs <= (player.y - intersec_y).abs then
				player.land(intersec_y)
			else
				player.fall
				player.hit_side_left(intersec_x)
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
			if (player.x - intersec_x).abs <= (player.y - intersec_y).abs then
				player.land(intersec_y)
			else
				player.fall
				player.hit_side_right(intersec_x)
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
