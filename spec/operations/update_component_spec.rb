require 'rails_helper'

RSpec.describe UpdateComponent do
  let!(:survey) { create(:survey) }
  let!(:component) { create(:component, survey: survey) }

  describe '.call' do
    context 'When params are valid' do
      it 'Should update component and return success response' do
        response = described_class.call(survey, component.id, { field: 'label', x_axis: 2.0, y_axis: 2.0 })
        expect(response[:status]).to eq(:success)
        expect(response[:result].field).to eq('label')
        expect(response[:result].x_axis).to eq(2.0)
        expect(response[:result].y_axis).to eq(2.0)
        expect(response[:errors]).to be_empty
      end
    end

    context 'When params are invalid' do
      it 'Should not update the component and return failure response' do
        response = described_class.call(survey, component.id, { field: '', x_axis: nil, y_axis: nil })
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(["X axis can't be blank, Y axis can't be blank, Field can't be blank"])
      end
    end

    context 'When component does not exist' do
      it 'Should return failure response' do
        response = described_class.call(survey, 78, { field: 'label', x_axis: 2.0, y_axis: 2.0 })
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(['Component not found'])
      end
    end

    context 'When an exception is raised' do

      it 'tracks the exception error' do
        allow_any_instance_of(Component).to receive(:update).and_raise(StandardError, 'error')
        response = described_class.call(survey, component.id, { field: 'label', x_axis: 2.0, y_axis: 2.0 })
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(['error'])
      end
    end
  end
end
