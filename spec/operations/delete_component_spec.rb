require 'rails_helper'

RSpec.describe DeleteComponent do
  let!(:survey) { create(:survey) }
  let!(:component) { create(:component, survey: survey) }

  describe '.call' do
    context 'When the component exists and is not deleted' do
      it 'Should delete the component and returns a success response' do
        response = described_class.call(survey, component.id)
        expect(response[:status]).to eq(:success)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to be_empty
        expect(Component.with_deleted.find(component.id).deleted?).to be_truthy
      end
    end

    context 'When component does not exist' do
      it 'Should return failure response' do
        response = described_class.call(survey, 98)
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(["Component not found for survey: #{survey.name}"])
      end
    end

    context 'When the component is already deleted' do

      it 'Should not raise an error and returns a success response' do
        component.destroy
        response = described_class.call(survey, component.id)
        expect(response[:status]).to eq(:success)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to be_empty
      end
    end

    context 'When an exception is raised' do

      it 'tracks the exception error' do
        allow_any_instance_of(Component).to receive(:destroy).and_raise(StandardError, 'error')
        response = described_class.call(survey, component.id)
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(['error'])
      end
    end
  end
end
