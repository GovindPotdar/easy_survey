require 'rails_helper'

RSpec.describe CreateSurvey do

  describe '.call' do
    context 'When params are valid' do
      it 'Should create a new survey and return success response' do
        valid_params = { name: 'name', description: 'description' }
        response = described_class.call(valid_params)
        expect(response[:status]).to eq(:success)
        expect(response[:result]).to be_a(Survey)
        expect(response[:result].name).to eq('name')
        expect(response[:errors]).to be_empty
      end
    end

    context 'When params are invalid' do
      it 'Should not create new survey and return failure response' do
        invalid_params = { name: '', description: '' }
        response = described_class.call(invalid_params)
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(["Name can't be blank"])
      end
    end

    context 'when an exception is raised' do
      it 'Should track the exception error' do
        allow(Survey).to receive(:new).and_raise(StandardError, 'error')
        valid_params = { name: 'name', description: 'description' }
        response = described_class.call(valid_params)
        expect(response[:status]).to eq(:failure)
        expect(response[:result]).to be_nil
        expect(response[:errors]).to match_array(['error'])
      end
    end
  end
end
