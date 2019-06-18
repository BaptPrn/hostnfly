class Reservation < ApplicationRecord
  belongs_to :listing

  after_save :create_checkout_checkin_mission
  before_destroy :destroy_checkout_checkin_missions

  private

  def create_checkout_checkin_mission
    MissionsService.new(object: self).create_relevant_missions
  end

  def destroy_checkout_checkin_missions
    Mission.where(listing_id: listing_id, date: end_date, mission_type: 'checkout_checkin')&.destroy_all
  end
end
