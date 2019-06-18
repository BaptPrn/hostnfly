FactoryBot.define do
  factory :listing do
    num_rooms { 1 }
  end

  factory :booking do
    start_date { Date.current }
    end_date { Date.current + 1.week }
    listing
  end

  factory :reservation do
    start_date { Date.tomorrow }
    end_date { Date.current + 3.days }
    listing
  end

  factory :mission do
    date { Date.current + 3.days }
    price { 10 }
    mission_type { 'first_checkin' }
    listing
  end
end
