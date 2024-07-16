require 'rails_helper'

RSpec.describe ErrorTracker do

  describe '#initialize' do
    it 'Should initializes with empty errors' do
      error_tracker = ErrorTracker.new
      expect(error_tracker.errors).to eq([])
    end
  end

  describe '#add_error' do
    it 'Should add a single error to the errors' do
      error_tracker = ErrorTracker.new
      error_tracker.add_error('test error')
      expect(error_tracker.errors).to include('test error')
    end

    it 'Should add multiple errors to the errors' do
      error_tracker = ErrorTracker.new
      error_tracker.add_error(['test error 1', 'test error 2'])
      expect(error_tracker.errors).to include('test error 1', 'test error 2')
    end
  end

  describe '#any?' do
    context 'When there are no errors' do
      it 'Should returns false' do
        error_tracker = ErrorTracker.new
        expect(error_tracker.any?).to be_falsey
      end
    end

    context 'When there are errors' do
      it 'Should returns true' do
        error_tracker = ErrorTracker.new
        error_tracker.add_error('test error')
        expect(error_tracker.any?).to be_truthy
      end
    end
  end
end
