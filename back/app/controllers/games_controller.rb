class GamesController < ApplicationController
  # GET /games
  # GET /games.xml
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end


  # POST /games
  # POST /games.xml
  def create
	u = User.find_by_uuid(session[:user_uuid])
	params[:game][:owner_uuid] = u.uuid;
	params[:game][:player_uuid] = u.uuid;
	
	#turn_speed
	days = Integer(params[:date][:days]) * 24 * 60
	hours = Integer(params[:date][:hours]) * 60
	minutes = Integer(params[:date][:minutes])
	turn_speed_minutes = days + hours + minutes;
	params[:game][:turn_speed_minutes] = turn_speed_minutes
	
	#turn_expiration
	exp = Time.now
	print "\nIt was " + exp.to_datetime.to_s + "\n"
	exp += turn_speed_minutes * 60
	print "\nIt's now " + exp.to_datetime.to_s + "\n"
	params[:game][:turn_expiration] = exp.to_datetime

	m = Map.find_by_uuid(params[:game][:map_uuid])
	params[:game][:current_map] = m.data;
	
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully created.'
        format.html { redirect_to(@game) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
end
