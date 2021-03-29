class LendingsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_lending, only: [:edit, :show, :destroy]

  def index
    # binding.pry
    @lendings = Lending.order(created_at: 'ASC')
    # @lendings = Lending.all
  end

  def new
  # binding.pry
    @lending = Lending.new
  end

  def create
    # binding.pry
    @lending = Lending.new(lending_params)
    # binding.pry
    if @lending.save
      # redirect_to root_path
      redirect_back(fallback_location: root_path)
    else
      # render :new
    end
  end

  def show
  end

  def edit
    # binding.pry
    redirect_to root_path unless member_signed_in? 
  end

  def update
  end

  def destroy
    # binding.pry
    @lending = Lending.find_by(member_id: current_member.id, item_id: params[:item_id])
    @lending.destroy if member_signed_in? 
    # redirect_to root_path
    redirect_back(fallback_location: root_path)
  end

  private

  def lending_params
    # binding.pry
    # params.require(:lending).permit("starttime(1i)", "starttime(2i)", "starttime(3i)", "starttime(4i)", "starttime(5i)", "finishtime(1i)", "finishtime(2i)", "finishtime(3i)", "finishtime(4i)", "finishtime(5i)")
    #     .merge(member_id: current_member.id, item_id: params[:item_id])
    params.require(:lending).permit("starttime", "finishtime")
        .merge(member_id: current_member.id, item_id: params[:item_id])
    # params.permit(:starttime, :finishtime, :item_id)
    #     .merge(member_id: current_member.id)
    # params.permit(:starttime(1i), :starttime(2i), :starttime(3i), :starttime(4i), :starttime(5i), :finishtime(1i), :finishtime(2i), :finishtime(3i), :finishtime(4i), :finishtime(5i), :item_id)
    #     .merge(member_id: current_member.id)
  end

  def set_lending
    # binding.pry
    # @lending = Lending.find(params[:id])
  end
  
end
