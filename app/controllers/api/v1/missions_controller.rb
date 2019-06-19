class Api::V1::MissionsController < Api::ApiController
  def index
    @missions = find_missions
    if @missions.present?
      render(
        json: @missions,
        each_serializer: Api::V1::MissionSerializer
      )
    else
      render(
        json: { message: 'No mission found' },
        status: 404
      )
    end
  end

  private

  def mission_params
    params.permit(:mission_type)
  end

  def find_missions
    if mission_params.present?
      Mission.where(mission_type: mission_params[:mission_type])
    else
      Mission.all
    end
  end
end
