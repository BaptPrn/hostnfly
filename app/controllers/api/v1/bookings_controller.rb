class Api::V1::BookingsController < Api::ApiController
  def index
    @bookings = Booking.all
    if @bookings.present?
      render(
        json: @bookings,
        each_serializer: Api::V1::BookingSerializer
      )
    else
      render(
        json: { message: 'No booking found' },
        status: 404
      )
    end
  end

  def show
    @booking = Booking.find(params[:id])
    if @booking
      render(
        json: @booking,
        serializer: Api::V1::BookingSerializer
      )
    else
      render(
        json: { message: 'No booking found for the id provided' },
        status: 404
      )
    end
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      render(
        json: @booking,
        serializer: Api::V1::BookingSerializer,
        status: :created
      )
    else
      render(
        json: { message: 'The booking creation failed'},
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    @booking = Booking.find(params[:id])

    @booking.destroy
    head :no_content
  end

  private

  def booking_params
    params.require(:booking).permit(:listing_id, :start_date, :end_date)
  end
end
