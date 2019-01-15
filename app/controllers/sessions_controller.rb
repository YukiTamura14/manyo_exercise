class SessionsController < ApplicationController
  skip_before_action :login_required
  before_action :redirect_if_logged_in, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user &.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:alert] = "メールアドレスまたはパスワードの入力に誤りがあります。"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def redirect_if_logged_in
    redirect_to tasks_path if current_user.present?
  end
end
