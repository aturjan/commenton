class UsersController < ApplicationController
 
  def show
  	@user = User.find(params[:id]) 
  end

  def new
    puts params
 	if params[:commit] == "Log in"
     user = User.find_by(email: params[:users][:email].downcase)
    if user && user.authenticate(params[:users][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user
    else
        flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  else  
    @user = User.new
  end  

  end


  def destroy
    log_out
    redirect_to signup_url
  end

 def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the CommentOn!"
      redirect_to @user
    else
      render 'new'
    end
  end


   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
 
end
