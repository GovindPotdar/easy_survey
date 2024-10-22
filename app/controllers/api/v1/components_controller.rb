module Api
  module V1
      class ComponentsController < BaseController

        before_action :find_and_set_survey

        def index
          render json: { status: :success, result: @survey.components }
        end

        def create
          response = ::CreateComponent.call(@survey, permit_params)
          render json: response
        end

        def update
          response = ::UpdateComponent.call(@survey, params[:id], permit_params)
          render json: response
        end
        
        def bulk_update
          response = ::BulkUpdateComponents.call(@survey, params[:components])
          render json: response
        end

        def destroy
          response = ::DeleteComponent.call(@survey, params[:id])
          render json: response
        end

        private 
    
        def find_and_set_survey
          @survey = Survey.find_by_id(params[:survey_id])
          render json: {status: :failure, errors: ["Survey not found!"]} and return if @survey.blank?
        end

        def permit_params
          params.require(:component).permit(:field, :text, :x_axis, :y_axis)
        end
      end
    end
  end    
