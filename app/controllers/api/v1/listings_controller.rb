class Api::V1::ListingsController < Api::ApiController
  def index
    @listings = Listing.all
    if @listings.present?
      render(
        json: @listings,
        each_serializer: Api::V1::ListingSerializer
      )
    else
      render(
        json: { message: 'No listing found' },
        status: 404
      )
    end
  end

  def show
    @listing = Listing.find(params[:id])
    if @listing
      render(
        json: @listing,
        serializer: Api::V1::ListingSerializer
      )
    else
      render(
        json: { message: 'No listing found for the id provided' },
        status: 404
      )
    end
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.save
    render(
      json: @listing,
      serializer: Api::V1::ListingSerializer,
      status: :created
    )
  rescue
    render(
      json: { message: 'The listing creation failed'},
      status: :unprocessable_entity
    )
  end

  def destroy
    @listing = Listing.find(params[:id])

    @listing.destroy
    head :no_content
  end

  private

  def listing_params
    params.require(:listing).permit(:num_rooms)
  end
end
