class Api::V1::BookingSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date

  belongs_to :listing
end
