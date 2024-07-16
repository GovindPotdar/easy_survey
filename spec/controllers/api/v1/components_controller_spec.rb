# spec/controllers/api/v1/components_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::ComponentsController, type: :controller do
    let!(:survey) { create(:survey) }

    context "Invalid request" do
    it "Should return invalid api-key error for invalid x-api-key" do
        request.headers['HTTP_API_KEY'] = 'invalidapikey'
        get :index, params: { survey_id: survey.id, format: :json }
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)['errors']).to match_array("Invalid API key")
    end

    it "Should return invalid x-api-key error for missing x-api-key header" do
        get :index, params: { survey_id: survey.id, format: :json }
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)['errors']).to match_array("Invalid API key")
    end
    end

    context "When request is valid" do
        before { request.headers['HTTP_API_KEY'] = '123456' }

        context 'When survey does not exist' do
            it 'Should return error' do
                get :index, params: { survey_id: 54, format: :json }
                expect(response.status).to eq(200)
                result = JSON.parse(response.body)
                expect(result['status']).to eq('failure')
                expect(result['errors']).to match_array(['Survey not found!'])
            end
        end

        describe '#index' do
            let!(:component1) { create(:component, survey: survey) }
            let!(:component2) { create(:component, survey: survey) }
            let!(:component3) { create(:component, survey: survey) }

            it 'Should return correct data' do
                get :index, params: { survey_id: survey.id, format: :json }
                expect(response.status).to eq(200)
                result = JSON.parse(response.body)
                expect(result['status']).to eq('success')
                expect(result['result'].count).to eq(3)
                expect(result['result'].pluck('id')).to match_array([component1.id, component2.id, component3.id])
            end
        end

        describe '#create' do
            it 'Should call CreateComponent to create component' do
                expect(CreateComponent).to receive(:call).with(survey, kind_of(ActionController::Parameters)).and_return({ status: :success })
                post :create, params: { survey_id: survey.id, format: :json, component: { field: 'label', text: '', x_axis: 1.0, y_axis: 1.0 } }
                result = JSON.parse(response.body)
                expect(result['status']).to eq('success')
            end
        end

        describe '#update' do
            let!(:component) { create(:component, survey: survey) }
            it 'Should call UpdateComponent to update component' do
                expect(UpdateComponent).to receive(:call).with(survey, component.id.to_s, kind_of(ActionController::Parameters)).and_return({ status: :success })
                put :update, params: { survey_id: survey.id, id: component.id, format: :json, component: { field: 'label', x_axis: 2.0, y_axis: 2.0 } }
                result = JSON.parse(response.body)
                expect(result['status']).to eq('success')
            end
        end

        describe '#bulk_update' do
            let!(:component1) { create(:component, survey: survey) }
            let!(:component2) { create(:component, survey: survey) }

            it 'Should call BulkUpdateComponents to update components' do
                expect(BulkUpdateComponents).to receive(:call).with(survey, kind_of(Array)).and_return({ status: :success })
                put :bulk_update, params: { survey_id: survey.id, format: :json, components: [{ id: component1.id, field: 'label', x_axis: 2.0, y_axis: 2.0 }, { id: component2.id, field: 'label', x_axis: 3.0, y_axis: 3.0 }] }
                result = JSON.parse(response.body)
                expect(result['status']).to eq('success')
            end
        end

        describe '#destroy' do
            let!(:component) { create(:component, survey: survey) }
            it 'Should call DeleteComponent to delete component' do
                expect(DeleteComponent).to receive(:call).with(survey, component.id.to_s).and_return({ status: :success })
                delete :destroy, params: { survey_id: survey.id, id: component.id, format: :json }
                result = JSON.parse(response.body)
                expect(result['status']).to eq('success')
            end
        end
    end
end
