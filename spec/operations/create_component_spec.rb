require 'rails_helper'

RSpec.describe CreateComponent do
  let!(:survey) { create(:survey) }

  describe '.call' do
    context 'When params are valid' do
      it 'Should create new component and return success response' do
        response = described_class.call(survey, { field: 'label', x_axis: 1.0, y_axis: 1.0 })
        expect(response[:status]).to eq(:success)
        expect(response[:result].field).to eq('label')
        expect(response[:errors]).to be_empty
      end
    end

    context 'When params are invalid' do
      it 'Should not create new component and return failure response' do
        response = described_class.call(survey, { field: '', x_axis: nil, y_axis: nil })
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(["X axis can't be blank, Y axis can't be blank, Field can't be blank"])
      end
    end

    context 'When an exception is raised' do
        
      it 'Should track the exception error' do
        allow(survey.components).to receive(:new).and_raise(StandardError, 'error')
        response = described_class.call(survey, { field: 'label', x_axis: 1.0, y_axis: 1.0 })
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(['error'])
      end
    end
  end
end
