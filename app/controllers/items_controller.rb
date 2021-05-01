class ItemsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :destroy]
  before_action :search_item, only: [:index, :search, :csv_search]

  require 'csv'
  require 'core_ext/string'

  def index
    # binding.pry
    @items = Item.includes(:member).page(params[:page]).per(10).order(created_at: 'DESC')
    # @items = Item.includes(:member).order(created_at: 'DESC')
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
    # 本日の予約が無いか調べ、あったらその情報をインスタンス変数(@reservation2)に入れてビューへ送る
    if member_signed_in? 
      @reservation2 = Reservation.where(item_id: @item.id, member_id: current_member.id, starttime: Date.current.all_day).order(starttime: 'ASC').limit(1)
      if @reservation2.length != 0
        # binding.pry
        # 予約から利用用に、@lending2を作る
        @lending2 = Lending.new
        @lending2.starttime = @reservation2[0].starttime
        @lending2.finishtime = @reservation2[0].finishtime
      else
        @lending2 = nil 
      end
    else
      @reservation2 = nil
      @lending2 = nil
    end
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
    if params[:CSVoutput]
      csv_search
      # redirect_back(fallback_location: root_path)
    end
    @results = @p.result.includes(:member).page(params[:page]).per(10).order(created_at: 'DESC')  # 検索条件にマッチした商品の情報を取得
    # @items = Item.includes(:member).page(params[:page]).per(10).order(created_at: 'DESC')
    # @items = @results
    # binding.pry
  end

  def csv_search
    head :no_content

    # @results_csv = @results
    # @results_csv = @p.result.includes(:member).page(params[:page]).per(10).order(created_at: 'DESC')  # 検索条件にマッチした商品の情報を取得
    @results_csv = @p.result.includes(:member).order(created_at: 'ASC')  # 検索条件にマッチした全ての備品情報を取得
    # binding.pry

    #ファイル名を指定
    filename = 'Item_' + Time.current.strftime("%Y%m%d%H%M%S")

    columns = ["category_name", "location_name", "department_name"] #追加分

    csv1 = CSV.generate do |csv|
      
      csv << Item.column_names + columns
      # csv << columns
        @results_csv.each do |result|
        result_attributes = result.attributes
       #user.attributesオブジェクトにtown_nameというキー名でtownテーブルのnameカラムを追加する
       #includesで結合しても呼び出すときはuser.nameではなくuser.town.nameなので注意
        result_attributes["category_name"] = result.category.name
        result_attributes["location_name"] = result.location.name
        result_attributes["department_name"] = result.department.name
        # csv << result_attributes.values_at(*Item.column_names) + result_attributes.values_at(*columns)
        csv << result_attributes.values_at(*Item.column_names , *columns)
        # csv << result_attributes.values_at(*columns)
      end
    end

    # csv1 = CSV.generate do |csv|
    #   #カラム名を1行目として入れる
    #   csv << columns
    #   # binding.pry

    #   @results_csv.each do |result|
    #     result_attribules = result.attributes
    #     user_attributes["category_name"] = result.category.name
    #     user_attributes["location_name"] = result.location.name
    #     user_attributes["department_name"] = result.department.name
    #     #各行の値を入れていく
    #     csv << result_attribules.values_at(*columns)
    #   end
    # end
    # binding.pry
    create_csv(filename, csv1)
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
  
  def create_csv(filename, csv1)
    # 文字コード変換のエラー対策
    csv1.sjisable

    #ファイル書き込み
    File.open("./#{filename}.csv", "w", encoding: "SJIS") do |file|
      file.write(csv1)
    end
    #send_fileを使ってCSVファイル作成後に自動でダウンロードされるようにする
    stat = File::stat("./#{filename}.csv")
    send_file("./#{filename}.csv", filename: "#{filename}.csv", length: stat.size)
  end

end
