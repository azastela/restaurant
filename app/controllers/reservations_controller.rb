class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:update, :destroy]

  def index
    @reservations = Reservation.all
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      head :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def update
      if @reservation.update(reservation_params)
        head :ok
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
  end

  def list
    if request.xhr?
      @reservations = Reservation.by_table(params[:table_id])
      @table_id = params[:table_id]
      render '_reservations', layout: false
    end
  end

  def destroy
    @reservation.destroy
    head :ok
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:start_time, :end_time, :table_id)
    end
end
