class Api::V1::MissionSerializer < ActiveModel::Serializer
  attributes :listing_id, :mission_type, :date, :price
end
