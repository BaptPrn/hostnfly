require 'rails_helper'

describe Reservation do
  it { should belong_to(:listing) }

  describe '#create_checkout_checkin_mission' do
    it 'calls the MissionsService to create the required checkout_checkin mission' do
      create(:reservation)

      expect(Mission.checkout_checkin.count).to eq(1)
    end
  end

  describe '#destroy_checkout_checkin_missions' do
    it 'destroys the checkout_checkin mission related to the reservation' do
      booking = create(:booking, end_date: Date.current + 7.days)
      reservation = create(:reservation, listing: booking.listing, end_date: Date.current + 5.days)

      reservation.destroy

      expect(Mission.checkout_checkin.count).to eq(0)
    end

    it 'does not do anything if a checkout_checkin mission is on the end_date but for another listing' do
      booking = create(:booking, end_date: Date.current + 7.days)
      reservation = create(:reservation, listing: booking.listing, end_date: Date.current + 5.days)
      create(:mission, date: Date.current + 5.days, mission_type: 'checkout_checkin')

      reservation.destroy

      expect(Mission.checkout_checkin.count).to eq(1)
    end

    it 'does not do anything for checkout_checkin mission on other dates' do
      booking = create(:booking, end_date: Date.current + 7.days)
      reservation = create(:reservation, listing: booking.listing, end_date: Date.current + 5.days)
      create(:mission, listing: reservation.listing, date: Date.current + 10.days, mission_type: 'checkout_checkin')

      reservation.destroy

      expect(Mission.checkout_checkin.count).to eq(1)
    end
  end
end
