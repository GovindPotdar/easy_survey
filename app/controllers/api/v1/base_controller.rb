class Api::V1::BaseController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :verify_api_token

    private
    def verify_api_token
        unless valid_token?
            render json: { status: :unauthorized, errors: ["Invalid API key"] }, status: 401 and return
        end
    end

    def valid_token?
        request.headers['HTTP_API_KEY'].present? && request.headers['HTTP_API_KEY'] == Rails.application.secrets.PUBLIC_API_KEY
    end
end
