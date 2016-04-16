class SessionsController < ApplicationController


def new
end

def homepage
end

def create
  @user = User.find_by_email(params[:session][:email])
  if @user && @user.authenticate(params[:session][:password])
    session[:user_id] = @user.id
    redirect_to '/new_recharge', :notice => "Logged in!"
  else
    flash.now.alert = "Invalid email or password"
    redirect_to '/login'
  end
end


def destroy 
  session[:user_id] = nil 
  redirect_to '/login' 
end



def fblogin
  user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to '/new_recharge'
end

def pingus
end

def cheatcodes
end


end
