$FOLDER = File.dirname(__FILE__) + "/"

require $FOLDER+'data_const.rb'

class World
	attr_reader :start_x, :start_y

	def initialize
			# initialisation des attributs
		@ground_tiles = Gosu::Image::load_tiles($FOLDER+"media/ground.png", GROUND_TILES_SIZE, GROUND_TILES_SIZE, :tileable => true)
		@entities = Array.new
		@ground = Array.new
		
			# lecture du fichier de niveau
		level = File.open($FOLDER+"level_1.rsh", "r")
		level_lines = level.readlines
		level.close
		
			# enregistrement de la taille du fichier de niveau
		maxX = level_lines.size		# nombre de lignes
		maxY = level_lines[0].size	# nombre de colonnes
		
			# conversion des lignes sous forme de chaine de caractères en tableau de caractères
			# et verification du formatage du fichier (toutes les lignes doivent avoir la même taille)
		level_lines_list = Array.new
		level_lines.each { |line|
			if line.size != maxY then
				print "une des lignes du fichier de niveau est incorrecte\n"
				exit
			end
			level_lines_list << line.split(//)
		}
		
		maxX -= 1	# numéro de ligne max
		maxY -= 2	# numéro de colonne max
		
			# remplissage du tableau @ground en fonction des données formatés du fichier
		for i in 0..maxY
			u = Array.new
			for j in 0..maxX
				u << [@ground.size*GROUND_TILES_SIZE,u.size*GROUND_TILES_SIZE,rand(@ground_tiles.size)] if level_lines_list[j][i] == "1"
				u << [@ground.size*GROUND_TILES_SIZE,u.size*GROUND_TILES_SIZE,@ground_tiles.size] if level_lines_list[j][i] == "0"
			end
			@ground << u
		end
		
		@start_x = 50
		@start_y = -50
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
		@ground.each { |line|
			line.each { |data|
				@ground_tiles[data[2]].draw(data[0]-x+mid_x, data[1]-y+mid_y, 0) if data[2]!=@ground_tiles.size
			}
		}
		
		@entities.each { |a| a.draw }
	end
end
