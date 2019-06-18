require 'rails_helper'

describe Booking do
  it { should belong_to(:listing) }

  describe '#create_first_and_last_missions' do
    it 'calls the MissionsService to create the required missions' do
      create(:booking)

      expect(Mission.first_checkin.count).to eq(1)
      expect(Mission.last_checkout.count).to eq(1)
    end
  end

  describe '#destroy_reservations_and_missions' do
    it 'should destroy the reservations and missions related to the booking' do
      booking = create(:booking)
      create(:reservation, listing: booking.listing, start_date: Date.tomorrow, end_date: Date.current + 2.days)
      create(:reservation, listing: booking.listing, start_date: Date.current + 3.days, end_date: Date.current + 5.days)

      expect(Mission.first_checkin.count).to eq(1)
      expect(Mission.last_checkout.count).to eq(1)
      expect(Mission.checkout_checkin.count).to eq(2)

      booking.destroy

      expect(Mission.count).to eq(0)
      expect(Reservation.count).to eq(0)
    end

    it 'should not do anything with reservations and missions not related to the booking' do
      booking = create(:booking)
      create(:reservation, listing: booking.listing, start_date: Date.tomorrow, end_date: Date.current + 2.days)
      create(:reservation, listing: booking.listing, start_date: Date.current + 10.days, end_date: Date.current + 12.days)

      expect(Mission.count).to eq(4)
      expect(Mission.first_checkin.count).to eq(1)
      expect(Mission.last_checkout.count).to eq(1)
      expect(Mission.checkout_checkin.count).to eq(2)

      booking.destroy

      expect(Reservation.count).to eq(1)
      expect(Mission.count).to eq(1)
    end
  end
end
