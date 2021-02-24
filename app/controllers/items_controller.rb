class ItemsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :destroy]

  def index
    # binding.pry
    @items = Item.order(created_at: 'DESC')
    # @items = Item.all
  end

  def new
    @item = Item.new
    # binding.pry
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # @lending.starttime = Date.today
    # @lending.starttime = Time.now
    if @item.lending == nil
      @lending = Lending.new
      @lending.starttime = Time.current.floor_to(15.minutes)
      @lending.finishtime = Time.current.floor_to(15.minutes) + 3600 * 2
    else
      # binding.pry
      # set_lending
      @lending = Lending.find_by(item_id: @item.id)
    end
  end

  def edit
    redirect_to root_path unless member_signed_in? 
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path(params[:id])
    else
      @item = item
      render :edit
    end
  end

  def destroy
    @item.destroy if member_signed_in? 
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :category_id, :detail, :location_id, :department_id,
                                 :member_id, :purchase_date, :image)                 
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_lending
    @lending = Lending.find_by(member_id: @item.member_id, item_id: @item.id)
  end
  
end
