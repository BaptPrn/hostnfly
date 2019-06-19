class Api::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  include ActionController::Serialization

  def not_found
    render json: {status: 404, errors: "Not found"}
  end
end

