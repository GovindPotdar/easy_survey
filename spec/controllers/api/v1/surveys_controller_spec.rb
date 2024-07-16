require 'rails_helper'

RSpec.describe Api::V1::SurveysController, type: :controller do

  context "Invalid request" do
    it "Should return invalid api-key error for invalid x-api-key" do
      request.headers['HTTP_API_KEY'] = 'invalidapikey'
      get :index, params: { format: :json }
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['errors']).to match_array("Invalid API key")
    end

    it "Should return invalid x-api-key error for missing x-api-key header" do
      get :index, params: { format: :json }
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['errors']).to match_array("Invalid API key")
    end
  end

  context "When request is valid" do
    before { request.headers['HTTP_API_KEY'] = '123456' }

    describe 'index' do
      let!(:survey1) { create(:survey) }
      let!(:survey2) { create(:survey) }
      let!(:survey3) { create(:survey) }
  
      it "Should return correct data" do
        get :index, params: { format: :json }
        expect(response.status).to eq(200)
        result = JSON.parse(response.body) 
        expect(result["status"]).to eq("success")
        expect(result["result"].count).to eq(3)
        expect(result["result"].pluck "id").to match_array([survey1.id, survey2.id, survey3.id])
      end
    end

    describe 'create' do
      it "Should call CreateSurvey to create survey" do
        expect(CreateSurvey).to receive(:call).with(kind_of(ActionController::Parameters)).and_return({status: :success})
        post :create, params: { format: :json, survey: {name: "test survey", description: "test description"}}
        result = JSON.parse(response.body) 
        expect(result["status"]).to eq("success")
      end
    end
  end
end
