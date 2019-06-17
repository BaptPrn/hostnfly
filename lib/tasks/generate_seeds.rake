require './backend/backend_test.rb'

namespace :seeds do
  desc 'Generate seeds from backend_test.rb'
  task generate: ['environment', 'db:reset'] do
    @input.each do |model_and_seeds|
      if model_and_seeds[0] == :listings
        model_and_seeds[1].each do |attributes|
          Listing.create(attributes)
        end
      elsif model_and_seeds[0] == :bookings
        model_and_seeds[1].each do |attributes|
          Booking.create(attributes)
        end
      elsif model_and_seeds[0] == :reservations
        model_and_seeds[1].each do |attributes|
          Reservation.create(attributes)
        end
      end
    end
  end
end
