class DashboardController < ApplicationController


	def index
		require_admin
		@users=User.all
		@trackers=Tracker.all.order(created_at: :desc)
		@stats=@trackers.pluck("comp")
		 @p_count=Tracker.where("uid=? and finished=?", user,"").count
		respond_to do |format|
      format.html
      format.csv { send_data @trackers.to_csv}
      format.xls# { send_data @trackers.to_csv(col_sep: "\t")}
    end
	end

	def inbound
		@trackers=Tracker.where("comp=?","< ETA")
	end

	def neutral
		@trackers=Tracker.where("comp=?","On Time")
	end

	def outbound
		@trackers=Tracker.where("comp=?","> ETA")
	end


	def assign
		#params[:tid], params[:uid]
		puts params[:tid]
		@tracker = Tracker.new("ticket_id"=>params[:tid].first, "uid"=>params[:uid],"finished"=>"")

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to '/dashboard', notice: 'Ticket was assigned successfully.' }
        format.json { render :index, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
	end
end
