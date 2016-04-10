class TrackersController < ApplicationController
  before_action :set_tracker, only: [:show, :edit, :update, :destroy]

  # GET /trackers
  # GET /trackers.json
  def index
    @trackers = Tracker.all
    
  end

  def current
    @tracker = Tracker.new
    @trackers = Tracker.where('created_at > ? AND created_at < ?', Date.yesterday.beginning_of_day, Date.today.end_of_day).order(created_at: :desc)# => .sort_by &:created_at
   # Tracker.where("created_at between ? and ?", Date.yesterday.beginning_of_day, Date.today.end_of_day)
  end

  # GET /trackers/1
  # GET /trackers/1.json
  def show
  end

  # GET /trackers/new
  # def new
  #   @tracker = Tracker.new
  #   redirect_to '/trackers'
  # end

  # GET /trackers/1/edit
  def edit
  end

  # POST /trackers
  # POST /trackers.json
  def create
    @tracker = Tracker.new(tracker_params)

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to :root, notice: 'Tracker was successfully created.' }
        format.json { render :index, status: :created, location: @tracker }
      else
        format.html { render :new }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trackers/1
  # PATCH/PUT /trackers/1.json
  def update
    respond_to do |format|
      if @tracker.update(tracker_params)
        format.html { redirect_to @tracker, notice: 'Tracker was successfully updated.' }
        format.json { render :show, status: :ok, location: @tracker }
      else
        format.html { render :edit }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
    completed
  end

def completed
  @com=Tracker.where("id=?",params[:id]).pluck("finished").last
  if @com != ""
    @eta=Tracker.where("id=?",params[:id]).pluck("eta").last
    @a=Date.parse(@eta)
    @b=Date.parse(@com)
    puts @a
    puts @b
    @c=(@a-@b).to_i
    if @c>0
      @complt="+"
    elsif @c==0
      @complt="0"
    elsif @c<0
      @complt="-"
    end
    puts "oooo====#{@complt}"
@tracker.update(:comp => @complt)
end
end


  # DELETE /trackers/1
  # DELETE /trackers/1.json
  def destroy
    @tracker.destroy
    respond_to do |format|
      format.html { redirect_to trackers_url, notice: 'Tracker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracker
      @tracker = Tracker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tracker_params
      params.require(:tracker).permit(:ticket_id, :comp, :staging, :created, :eta, :finished, :tow, :owner, :noc, :disc)
    end


    def interlink
    end
end
