class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def create

  end

  def show
    @cat = Cat.find_by_id(params[:id])
  end


  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :description, :birth_date)
  end
end
