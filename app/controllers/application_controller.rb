class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


helper_method :pending

 def pending
    @pendings=Tracker.where("finished=?", "")
    @p_count=@pendings.count
    return @p_count
end

def search
	@res=Tracker.where("ticket_id LIKE ?", "%#{params[:ticket_id]}%")
end
end
