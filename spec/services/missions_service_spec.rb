require 'rails_helper'

describe MissionsService do
  describe '#create_relevant_missions' do
    context 'when the object is a booking' do
      it 'create a first_checkin and a last_checkout missions' do
        listing = create(:listing)
        booking = build(:booking, listing: listing)

        MissionsService.new(object: booking).create_relevant_missions

        expect(booking.listing.missions.count).to eq(2)
        expect(Mission.first_checkin.count).to eq(1)
        expect(Mission.last_checkout.count).to eq(1)
      end
    end

    context 'when the object is a Reservation' do
      it 'creates a checkout_checkin mission when relevant' do
        booking = create(:booking, end_date: Date.current + 7.days)
        reservation = build(:reservation, listing: booking.listing, end_date: Date.current + 5.days)

        MissionsService.new(object: reservation).create_relevant_missions

        expect(Mission.checkout_checkin.count).to eq(1)
      end

      it "does not create any checkout_checkin mission when the end_date is the same as the booking's" do
        booking = create(:booking, end_date: Date.current + 7.days)
        reservation = build(:reservation, listing: booking.listing, end_date: Date.current + 7.days)

        MissionsService.new(object: reservation).create_relevant_missions

        expect(Mission.checkout_checkin.count).to eq(0)
      end
    end
  end

  describe "#calculate_price_for(mission_type: )" do
    it 'multiplies the listing number of rooms by 10 for a first_checkin mission and by 5 for a last_checkout mission' do
        listing = create(:listing, num_rooms: 5)
        booking = build(:booking, listing: listing)

        MissionsService.new(object: booking).create_relevant_missions

        expect(Mission.first_checkin.first.price).to eq(50)
        expect(Mission.last_checkout.first.price).to eq(25)
    end

    it 'multiplies the listing number of rooms by 10 for a checkout_checkin mission' do
        listing = create(:listing, num_rooms: 4)
        reservation = build(:reservation, listing: listing)

        MissionsService.new(object: reservation).create_relevant_missions

        expect(Mission.checkout_checkin.first.price).to eq(40)
    end
  end
end
