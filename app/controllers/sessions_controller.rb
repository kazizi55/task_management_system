class SessionsController < ApplicationController
  before_action :set_user, only: [:create]

  def create
    @user.authenticate(session_params[:password])
    sign_in(@user)
    redirect_to root_path
    redirect_to tasks_path, notice: "ログインしました" 
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
    @user = User.find_by!(mail: session_params[:mail])
  rescue
    flash.now[:alert] = "不正なメールアドレスです"
    render action: 'new'
  end

  def session_params
    params.require(:session).permit(:mail, :password)
  end
end
