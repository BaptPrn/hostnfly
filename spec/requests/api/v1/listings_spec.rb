require 'rails_helper'

describe 'GET /api/listings' do
  it 'returns all the listings' do
    create_list(:listing, 2)

    get(api_v1_listings_path)

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('listings')
  end
end

describe 'GET /api/listing' do
  it 'returns the listing searched' do
    listing = create(:listing)

    get(api_v1_listing_path(listing.id))

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('listing')
  end
end

describe 'POST /api/listings' do
  it 'successfully creates the the listing' do
    post(
      api_v1_listings_path,
      params: {
        listing: {
          num_rooms: 4
        }
      }
    )

    expect(response).to have_http_status(:created)
    expect(response).to match_response_schema('listing')
    expect(Listing.count).to eq(1)
  end

  it 'returns a 422 if the listing creation fails' do
    post(
      api_v1_listings_path,
      params: {
        listing: {
          num_rooms: nil
        }
      }
    )

    expect(response).to have_http_status(:unprocessable_entity)
  end
end

describe 'DELETE api/listing/:id' do
  it 'deletes a listing' do
    listing = create(:listing)

    delete(api_v1_listing_path(listing.id))

    expect(Listing.count).to eq(0)
    expect(response).to have_http_status(:no_content)
  end
end
