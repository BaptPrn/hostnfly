class Api::V1::ReservationSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date

  belongs_to :listing
end
