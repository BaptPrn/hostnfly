require 'rails_helper'

describe 'GET /api/reservations' do
  it 'returns all the reservations' do
    create_list(:reservation, 2)

    get(api_v1_reservations_path)

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('reservations')
  end
end

describe 'GET /api/reservation' do
  it 'returns the reservation searched' do
    reservation = create(:reservation)

    get(api_v1_reservation_path(reservation.id))

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('reservation')
  end
end

describe 'POST /api/reservations' do
  it 'successfully creates the the reservation' do
    listing = create(:listing)

    post(
      api_v1_reservations_path,
      params: {
        reservation: {
          listing_id: listing.id,
          start_date: Date.current,
          end_date: Date.tomorrow
        }
      }
    )

    expect(response).to have_http_status(:created)
    expect(response).to match_response_schema('reservation')
    expect(Reservation.count).to eq(1)
    expect(Reservation.last.start_date).to eq(Date.current)
    expect(Reservation.last.end_date).to eq(Date.tomorrow)
    expect(Reservation.last.listing_id).to eq(listing.id)
    expect(Mission.count).to eq(1)
  end

  it 'returns a 422 if the reservation creation fails' do
    post(
      api_v1_reservations_path,
      params: {
        reservation: {
          listing_id: nil,
          start_date: Date.current,
          end_date: Date.tomorrow
        }
      }
    )

    expect(response).to have_http_status(:unprocessable_entity)
  end
end

describe 'DELETE api/reservation/:id' do
  it 'deletes a reservation' do
    reservation = create(:reservation)

    delete(api_v1_reservation_path(reservation.id))

    expect(Reservation.count).to eq(0)
    expect(response).to have_http_status(:no_content)
  end
end
