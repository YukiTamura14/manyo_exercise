class UsersController < ApplicationController
  skip_before_action :login_required
  before_action :set_user, only: [:show]
  before_action :ensure_correct_user, only: [:show]
  before_action :redirect_if_logged_in, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(session[:user_id]), notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to tasks_path unless @user.id == current_user.id
  end

  def redirect_if_logged_in
    redirect_to tasks_path if current_user.present?
 end
end
