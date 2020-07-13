class UsersController < ApplicationController
  skip_before_action :require_sign_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    password = params[:user][:password]
    @user = User.new(user_params.merge(password: secure_pass(password)))
    @user.valid?
    @user.save!
    sign_in(@user)
    redirect_to tasks_path, notice: "ユーザーを登録しました" 
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "登録に失敗しました"
    render 'new'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
