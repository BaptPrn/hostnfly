class Booking < ApplicationRecord
  belongs_to :listing

  after_save :create_first_and_last_missions
  before_destroy :destroy_reservations_and_missions

  private

  def create_first_and_last_missions
    MissionsService.new(object: self).create_relevant_missions
  end

  def destroy_reservations_and_missions
    Reservation.where('listing_id = ? AND start_date BETWEEN ? AND ?', listing_id, start_date, end_date)&.destroy_all
    Mission.where('listing_id = ? AND (date = ? OR date = ?)', listing_id, start_date, end_date).destroy_all
  end
end
