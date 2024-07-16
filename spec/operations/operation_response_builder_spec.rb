require 'rails_helper'

RSpec.describe OperationResponseBuilder do
  describe '.call' do
    let(:error_tracker) { ErrorTracker.new }

    context 'When there are no errors' do
      it 'Should return success response' do
        response = described_class.call({}, error_tracker)
        expect(response[:result]).to eq({})
        expect(response[:status]).to eq(:success)
        expect(response[:errors]).to be_empty
      end
    end

    context 'When there are errors' do
      before do
        error_tracker.add_error('test error')
      end

      it 'Should return failure response' do
        response = described_class.call({}, error_tracker)
        expect(response[:result]).to eq({})
        expect(response[:status]).to eq(:failure)
        expect(response[:errors]).to include('test error')
      end
    end
  end
end
