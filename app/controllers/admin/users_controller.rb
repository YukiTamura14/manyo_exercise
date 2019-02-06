class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.recent.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました"
      redirect_to admin_users_path(@user)
    else
      flash.now[:danger] = "「#{@user.name}」は最後の管理者のため削除できません"
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "ユーザー「#{@user.name}」を削除しました"
    else
      flash[:danger] = "「#{@user.name}」は最後の管理者のため削除できません"
    end
      redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
