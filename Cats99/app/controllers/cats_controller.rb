class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
    flash[:errors] = ["Error"]
    render :new      # @errors = []
      # @errors << @cat.errors.full_messages
    end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    @requests = @cat.cat_rental_requests.order(:start_date)
  end

  def update
    @cat = Cat.find_by_id(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render flash: {error: @cat.errors.full_messages}
      @errors = []
      @errors << @cat.errors.full_messages
    end
  end



  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :description, :birth_date)
  end
end
