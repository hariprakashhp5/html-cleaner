class TrackersController < ApplicationController
  before_action :set_tracker, only: [:show, :edit, :update, :destroy]

  # GET /trackers
  # GET /trackers.json
  def index
    stats=Tracker.all.pluck("comp")
    @ontime=stats.count("On Time")
    @delay=stats.count("> ETA")
    @early=stats.count("< ETA")
    @trackers = Tracker.all.order(created_at: :desc)
    
  end

  def current
    @tracker = Tracker.new
    @trackers = Tracker.where('created_at > ? AND created_at < ?', Date.yesterday.beginning_of_day, Date.today.end_of_day).order(created_at: :desc)
    stats=@trackers.pluck("comp")
    @ontime=stats.count("On Time")
    @delay=stats.count("> ETA")
    @early=stats.count("< ETA")
   # Tracker.where("created_at between ? and ?", Date.yesterday.beginning_of_day, Date.today.end_of_day)
  end

def testcod
end

def posttestcod
    #@bundle_out=params[:content]
    #@bundle_out=params[:content].gsub(/(?:style|class|width|cellspacing|cellpadding|valign)="[\p{Print}]+"/,"")
    #@bundle_out=bundle_out.gsub(/<[[:alpha:]]+(>| >)(\\s|&nbsp;)+<\/[[:alpha:]]+>/,"").split(" ").join(" "), <li>.*<p>

      nogo={'<li> <p>'=>'<li>', '</p> </li>' => '</li>', '<td> <p>' => '<td>', '</p> </td>' => '</td>',
      '<p> </p>' => '','</p>' => "</p>\n", '</ul>' => "</ul>\n", '</ol>' => "</ol>\n", '</tr>' => "</tr>\n", 
      '</table>'=>"</table>\n", '&lt;' => '<', '&gt;'=>'>', '</h1>' => "</h1>\n", '</h2>' => "</h2>\n", 
      '</h3>' => "</h3>\n", '<br>' => '','<p></p>' => ''}
      c=params[:content]
      bundle_out=Sanitize.fragment(c,Sanitize::Config.merge(Sanitize::Config::BASIC,
      :elements=> Sanitize::Config::BASIC[:elements]+['table', 'tbody', 'tr', 'td', 'h1', 'h2', 'h3'],
      :attributes=>{'a' => ['href']}) ).split(" ").join(" ")
      re = Regexp.new(nogo.keys.map { |x| Regexp.escape(x) }.join('|'))
      @bundle_out=bundle_out.gsub(re, nogo)
end

# def cleaner
# end

# def htmlclnr
#       if params[:content] != nil
#       driver = Selenium::WebDriver.for :firefox
#       puts "browser open"
#       driver.navigate.to "http://www.html-cleaner.com/" 
#       puts "waiting fo element"
#       wait = Selenium::WebDriver::Wait.new(:timeout => 1000)
#       wait.until { driver.find_element(:id => "elm1_ifr").displayed? }
#       puts "found"
#       driver.find_element(:id => "optionButton15").click
#       driver.find_element(:id => "optionButton5").click
#       driver.find_element(:id => "optionButton16").click
#       puts "switching"
#       driver.switch_to.frame('elm1_ifr')
#       puts "switched"
#       driver.find_element(:id=>'tinymce').clear
#       driver.find_element(:id=>'tinymce').send_key params[:content]
# driver.switch_to.default_content
# driver.find_element(:id => "cleanButtonText").click
# @onestep=driver.find_elements(:css =>".CodeMirror-code > div > pre > span")
# #puts "bbb===#{@onestep}"  
# @onestep.each do |tagged|
#   @tag=tagged.attribute("textContent").split(" ").join(" ")
# end
# puts @tag
# #driver.find_element(:class => "CodeMirror-scroll").click
# #driver.keyboard.send_keys [:control, "a"]
# #@output=driver.keyboard.send_keys [:control, "c"]
# end
#     end



  def status
   @date = params[:month] ? Date.parse(params[:month]) : Date.today
     # @dat = Tracker.where('created_at > ? AND created_at < ?', @date.beginning_of_day, @date.end_of_month.end_of_day)
 @dat=Tracker.where("finished LIKE ?", "%#{@date.strftime("%-m-%y")}%")
stats=@dat.pluck("comp")
 @this_month_neutral=stats.count("On Time")
 @this_month_delay=stats.count("> ETA")
@this_month_early=stats.count("< ETA")

  
  # @dat_by_date = @dat.group_by(&:finished)
  # @mon = { 1=>"January", 2=>"Februrary", 3 =>"March", 4=>"April", 
  #           5=>"May", 6=>"June", 7=>"July", 8=>"Augest", 
  #            9=>"September", 10=>"October", 11=>"November", 12=>"December"} 
  #            p = Time.now
  #    n = p.month
  # @previous = @mon[n-1]
  # @next = @mon[n+1] 

    @trackers = Tracker.all
    @ontime=Tracker.where("comp = ?", "On Time").count
    @delay=Tracker.where("comp = ?", "> ETA").count
    @early=Tracker.where("comp = ?", "< ETA").count
  end

  # def pending{
  #   @pendings=Tracker.where("finished=?", "")
  #   @p_count=@pendings.count
  # }
#end
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
        @c=(@a-@b).to_i
    if @c>0
      @complt="< ETA"
    elsif @c==0
      @complt="On Time"
    elsif @c<0
      @complt="> ETA"
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

  def remove
    Tracker.delete_all
    redirect_to '/'
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
