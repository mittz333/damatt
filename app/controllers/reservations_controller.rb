class ReservationsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :set_reservation, only: [:edit, :show, :destroy]

  def index
    # binding.pry
    @reservations = Reservation.order(created_at: 'ASC').includes([:member, :item])
    # @reservations = Reservation.all
  end

  def new
  # binding.pry
    @reservation = Reservation.new
  end

  def create
    # binding.pry
    @reservation = Reservation.new(reservation_params)
    # binding.pry
    if @reservation.save
      redirect_to root_path
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
    reservation = Reservation.find(params[:id])
    # binding.pry
    reservation.destroy if member_signed_in? 
    redirect_to root_path
    # Reservationは同一itemで複数持てるから、注意
    # @reservation = Reservation.find_by(member_id: current_member.id, item_id: params[:item_id])
    # @reservation.destroy if member_signed_in? 
    # redirect_to root_path
  end

  private

  def reservation_params
    params.require(:reservation).permit("starttime(1i)", "starttime(2i)", "starttime(3i)", "starttime(4i)", "starttime(5i)", "finishtime(1i)", "finishtime(2i)", "finishtime(3i)", "finishtime(4i)", "finishtime(5i)")
        .merge(member_id: current_member.id, item_id: params[:item_id])
    # params.permit(:starttime, :finishtime, :item_id)
    #     .merge(member_id: current_member.id)
    # params.permit(:starttime(1i), :starttime(2i), :starttime(3i), :starttime(4i), :starttime(5i), :finishtime(1i), :finishtime(2i), :finishtime(3i), :finishtime(4i), :finishtime(5i), :item_id)
    #     .merge(member_id: current_member.id)
  end

  def set_reservation
    # binding.pry
    # @reservation = Reservation.find(params[:id])
  end
  
end
