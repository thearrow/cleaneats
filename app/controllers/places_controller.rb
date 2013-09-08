class PlacesController < ApplicationController
  before_action :set_place, only: [:edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    @places = Place.all
    render json: @places
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find_by(id_yelp: params[:id])
    render json: @place
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render action: 'show', status: :created, location: @place }
      else
        format.html { render action: 'new' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  # GET /search/{params}
  def search
    unless params[:lat].nil? or params[:lng].nil?
      @results = {:locations => Yelp.search(params[:lat], params[:lng])}
      get_lat_lngs()
      render json: @results
    end

    unless params[:where].nil?
      @results = {:locations => Yelp.search_text(params[:where])}
      center = Geocoder.search(params[:where]).first
      @results[:lat] = center.latitude.to_s
      @results[:lng] = center.longitude.to_s
      get_lat_lngs()
      render json: @results
    end
  end


private
    def get_lat_lngs
      @results[:locations].each do |r|
        place = Place.find_or_create_by(id_yelp: r.id)
        if place.latitude.nil? or place.longitude.nil?
          geo = Geocoder.search("#{r.location.address.first} #{r.location.city} #{r.location.state_code} #{r.location.postal_code}").first
          unless geo.nil?
            place.latitude = geo.latitude.to_s
            place.longitude = geo.longitude.to_s
          end
        end
        r.latitude = place.latitude
        r.longitude = place.longitude
        place.save!
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:id_citygrid, :id_yelp, :id_google)
    end
end
