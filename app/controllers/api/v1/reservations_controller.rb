class Api::V1::ReservationsController < Api::ApiController
  def index
    @reservations = Reservation.all
    if @reservations.present?
      render(
        json: @reservations,
        each_serializer: Api::V1::ReservationSerializer
      )
    else
      render(
        json: { message: 'No reservation found' },
        status: 404
      )
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    if @reservation
      render(
        json: @reservation,
        serializer: Api::V1::ReservationSerializer
      )
    else
      render(
        json: { message: 'No reservation found for the id provided' },
        status: 404
      )
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      render(
        json: @reservation,
        status: :created,
        serializer: Api::V1::ReservationSerializer
      )
    else
      render(
        json: { message: 'The reservation creation failed'},
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])

    @reservation.destroy
    head :no_content
  end

  private

  def reservation_params
    params.require(:reservation).permit(:listing_id, :start_date, :end_date)
  end
end
