class SubsController < ApplicationController
  before_action :ensure_signed_in!

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(subs_params)
    @sub.mod_id = current_user.id 
    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = current_user.modded_sub.find(params[:id])
    if @sub.update_attributes(subs_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private

  def subs_params
    params.require(:sub).permit(:title, :description)
  end
end
