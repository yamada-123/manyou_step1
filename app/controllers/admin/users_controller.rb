class Admin::UsersController < ApplicationController
  def index
      @users = User.all.order(created_at: :desc)

      #@users = User.where(admin:'false')#管理者以外を代入
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"ユーザー#{@user.name}を追加しました。"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー情報を編集しました"
    end
  end

  def destroy
    @user = User.find(params[:id])
    # if User.where(admin: 'true').count >= 2 || @user.admin == false
    if @user.destroy
      redirect_to admin_users_path, notice:"ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice:"管理者は一人以上いないといけません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end

#Aaa