class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new
  end

  def create
    if @user.password == secure_pass(params[:password])
      sign_in(@user)
      redirect_to tasks_path, notice: "ログインしました" 
    else
      raise ActiveRecord::RecordNotFound::new
    end
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "不正なパスワードです"
    render 'new'
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

  def set_user
    @user = User.find_by!(email: session_params[:email])
  rescue
    flash.now[:alert] = "不正なメールアドレスです"
    render action: 'new'
  end

  def session_params
    params.permit(:email, :password)
  end
end
