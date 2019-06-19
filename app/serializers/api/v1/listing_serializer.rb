class Api::V1::ListingSerializer < ActiveModel::Serializer
  attributes :id, :num_rooms

  has_many :bookings
  has_many :reservations
  has_many :missions
end
