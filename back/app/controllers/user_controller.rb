class UserController < ApplicationController
	
	def login
		if request.post?
			user = User.authenticate(params[:email], params[:password])
			if user
				session[:user_uuid] = user.uuid
				redirect_to(:action => "index")
			else
				flash.now[:notice] = "Invalid user/password combination"
			end
		end
	end
	
	# Returns the game uuid, game name and map name	for all of this users games
	def show_games
		games = Game.get_games
		@games = preview_games(games)
	end

	# Returns the game uuid, game name and map name	
	def index
		players = Player.get_game_uuids(session[:user_uuid])
		
		games = []
		players.each do |player|
			games.push(Game.get_game(player[:game_uuid]))
		end

		@games = preview_games(games)
	end
	
	
	
	
	
	# Trys to join a game
	def join
		params[:player] = {}
		params[:player][:game_uuid] = params[:game_uuid]
		params[:player][:user_uuid] = session[:user_uuid]
	
		@player = Player.new(params[:player])
		games = Game.get_games
		@games = preview_games(games)

		if @player.save
			flash[:notice] = 'You joined the game!'
			redirect_to :action => 'index'
		else
			flash[:notice] = 'Unable to join game'
			render :action => 'show_games'
		end
	end

	def logout
		session[:user_uuid] = nil
		flash[:notice] = "Logged out"
		redirect_to(:action => "login")
	end
	
private	
	# Returns hash of preview information of games, getting map information
	# * games: array of Games
	def preview_games(games)
		h = {}
		games.each do |g|
			m = Map.get_map(g[:map_uuid])
			h[g.uuid] = {:game_name => g[:name], :map_name => m.name, :players => m.players.to_s, :num_players => Player.num_players(g.uuid).to_s}
		end
		return h
	end
	

end