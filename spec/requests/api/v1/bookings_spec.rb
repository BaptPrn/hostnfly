require 'rails_helper'

describe 'GET /api/bookings' do
  it 'returns all the bookings' do
    create_list(:booking, 2)

    get(api_v1_bookings_path)

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('bookings')
  end
end

describe 'GET /api/booking' do
  it 'returns the booking searched' do
    booking = create(:booking)

    get(api_v1_booking_path(booking.id))

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('booking')
  end
end

describe 'POST /api/bookings' do
  it 'successfully creates the the booking' do
    listing = create(:listing)

    post(
      api_v1_bookings_path,
      params: {
        booking: {
          listing_id: listing.id,
          start_date: Date.current,
          end_date: Date.tomorrow
        }
      }
    )

    expect(response).to have_http_status(:created)
    expect(response).to match_response_schema('booking')
    expect(Booking.count).to eq(1)
    expect(Booking.last.start_date).to eq(Date.current)
    expect(Booking.last.end_date).to eq(Date.tomorrow)
    expect(Booking.last.listing_id).to eq(listing.id)
    expect(Mission.count).to eq(2)
  end

  it 'returns a 422 if the booking creation fails' do
    post(
      api_v1_bookings_path,
      params: {
        booking: {
          listing_id: nil,
          start_date: Date.current,
          end_date: Date.tomorrow
        }
      }
    )

    expect(response).to have_http_status(:unprocessable_entity)
  end
end

describe 'DELETE api/booking/:id' do
  it 'deletes a booking' do
    booking = create(:booking)

    delete(api_v1_booking_path(booking.id))

    expect(Booking.count).to eq(0)
    expect(response).to have_http_status(:no_content)
  end
end
