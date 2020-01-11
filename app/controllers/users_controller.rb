class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to tasks_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #redirect_to user_path(@user.id)
      log_in @user
      # binding.pry
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    # binding.pry
    @user = User.find(params[:id])
    if @user.id != current_user.id
      #binding.pry
      redirect_to user_path(current_user.id), notice: "他人のプロフィールなので閲覧できません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
