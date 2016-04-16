class UsersController < ApplicationController

def new
@user = User.new
end

def index
@users=User.all
end


def destroy
@user=User.find(params[:id])
@user.destroy
redirect_to '/users'
end

def create 
@user = User.new(user_params) 
if @user.save 
UserMailer.registration_confirmation(@user).deliver
#session[:user_id] = @user.id 
redirect_to '/login' 
else 
redirect_to '/signup' 
end 
end


def edit_pass
@user_pass = current_user
end

def update_password
@user_pass = User.find(current_user.id)
if @user_pass.update(user_params1)
# Sign in the user by passing validation in case their password changed
redirect_to '/new_recharge', :notice=>"Password changed Successfully"
else
render "edit_pass"
end
end


private
def user_params
params.require(:user).permit(:first_name, :last_name, :email, :mobile_number, :password, :password_confirmation)
end

def user_params1
# NOTE: Using `strong_parameters` gem
params.require(:user).permit(:password, :password_confirmation)
end

end

