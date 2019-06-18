require 'rails_helper'

describe Listing do
  it { should have_many(:bookings) }
  it { should have_many(:reservations) }
  it { should have_many(:missions) }
end
