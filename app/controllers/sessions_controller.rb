class SessionsController < ApplicationController
  respond_to :html

  def create
    auth = request.env["omniauth.auth"]  
    @user = User.find_by_provider_and_dailymile_id(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth) 
    @user.update_attributes(:image_url => auth['user_info']['image'])
    session[:user_id] = @user.id  
    respond_with @user do |format|
      format.html { redirect_to root_url, :notice => "Okay, you're signed in!" }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signup_url, :notice => "Okay, see you next time!"
  end
end
