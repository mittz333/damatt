class ItemsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :destroy]
  before_action :search_item, only: [:index, :search]

  def index
    # binding.pry
    @items = Item.order(created_at: 'DESC').includes(:member)
    # @items = Item.all
  end

  def new
    @item = Item.new
    @item.purchase_date = Date.current
    @item.member_id = current_member.id
    @item.department_id = current_member.department.id

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
    @reservation = Reservation.new
    @reservation.starttime = Time.current.floor_to(1440.minutes).since(1.days) + 3600 * 8
    @reservation.finishtime = @reservation.starttime + 3600 * 2
    # 
    @reservations = Reservation.where(item_id: @item.id).order(starttime: 'ASC')
    # binding.pry

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

  def search
    # binding.pry
    @results = @p.result.includes(:member)  # 検索条件にマッチした商品の情報を取得
    @items = @results
    # binding.pry
  end

  private

  def item_params
    params.require(:item).permit(:name, :category_id, :detail, :location_id, :department_id,
                                 :member_id, :purchase_date, :control_number, :image)                 
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_lending
    @lending = Lending.find_by(member_id: @item.member_id, item_id: @item.id)
  end
  
  def search_item
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end
  
end
