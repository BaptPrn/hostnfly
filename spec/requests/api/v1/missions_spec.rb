require 'rails_helper'

describe 'GET /api/missions' do
  it 'returns all the missions' do
    first_checkin_missions = create_list(:mission, 3, mission_type: 'first_checkin')
    last_checkout_missions = create_list(:mission, 5, mission_type: 'last_checkout')
    checkout_checkin_missions = create_list(:mission, 2, mission_type: 'checkout_checkin')

    get(api_v1_missions_path)

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('missions')
    expect(JSON.parse(response.body).count).to eq(10)
  end

  it 'returns only the first_checkin missions if the filter is required' do
    first_checkin_missions = create_list(:mission, 3, mission_type: 'first_checkin')
    last_checkout_missions = create_list(:mission, 5, mission_type: 'last_checkout')
    checkout_checkin_missions = create_list(:mission, 2, mission_type: 'checkout_checkin')

    get(api_v1_missions_path, params: { mission_type: 'first_checkin' })

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('missions')
    expect(JSON.parse(response.body).count).to eq(3)
  end

  it 'returns only the last_checkout missions if the filter is required' do
    first_checkin_missions = create_list(:mission, 3, mission_type: 'first_checkin')
    last_checkout_missions = create_list(:mission, 5, mission_type: 'last_checkout')
    checkout_checkin_missions = create_list(:mission, 2, mission_type: 'checkout_checkin')

    get(api_v1_missions_path, params: { mission_type: 'last_checkout' })

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('missions')
    expect(JSON.parse(response.body).count).to eq(5)
  end

  it 'returns only the checkout_checkin missions if the filter is required' do
    first_checkin_missions = create_list(:mission, 3, mission_type: 'first_checkin')
    last_checkout_missions = create_list(:mission, 5, mission_type: 'last_checkout')
    checkout_checkin_missions = create_list(:mission, 2, mission_type: 'checkout_checkin')

    get(api_v1_missions_path, params: { mission_type: 'checkout_checkin' })

    expect(response).to have_http_status(:ok)
    expect(response).to match_response_schema('missions')
    expect(JSON.parse(response.body).count).to eq(2)
  end

  it 'returns a 404 if no mission is found' do
    get(api_v1_missions_path)

    expect(response).to have_http_status(404)
  end
end
