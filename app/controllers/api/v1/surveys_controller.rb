module Api
  module V1
    class SurveysController < BaseController

      def index
        render json: {status: :success, result: Survey.all}
      end

      def create
        response = ::CreateSurvey.call(permit_params)
        render json: response
      end

      private 
  
      def permit_params
        params.require(:survey).permit(:name, :description)
      end
    end
  end    
end