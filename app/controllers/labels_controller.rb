class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = Label.all.update_order
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def require_author
    redirect_to labels_path unless @label.user_id == current_user.id
  end

  def label_params
    params.require(:label).permit(:name)
  end
end
