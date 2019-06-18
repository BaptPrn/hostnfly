class MissionsService
  def initialize(object:)
    @object_class = object.class.to_s
    @listing = object.listing
    @start_date = object.start_date
    @end_date = object.end_date
  end

  def create_relevant_missions
    if @object_class == 'Booking'
      create_mission(type: 'first_checkin', date: @start_date)
      create_mission(type: 'last_checkout', date: @end_date)
    elsif Mission.where(listing_id: @listing.id, date: @end_date).blank?
      create_mission(type: 'checkout_checkin', date: @end_date)
    end
  end

  private

  def create_mission(type:, date:)
    Mission.create(
      listing_id: @listing.id,
      date: date,
      mission_type: type,
      price: calculate_price_for(mission_type: type)
    )
  end

  def calculate_price_for(mission_type: )
    number_of_rooms = @listing.num_rooms
    if mission_type == 'last_checkout'
      5 * number_of_rooms
    else
      10 * number_of_rooms
    end
  end
end
