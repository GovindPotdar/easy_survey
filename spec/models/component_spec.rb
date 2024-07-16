# spec/models/component_spec.rb
require 'rails_helper'

RSpec.describe Component, type: :model do
  describe 'associations' do
    it { should belong_to(:survey) }
  end

  describe 'enums' do
    it { expect(described_class.fields).to include(label: "label", input_text: "input_text") }
  end

  describe 'validations' do
    it { should validate_presence_of(:x_axis) }
    it { should validate_presence_of(:y_axis) }
    it { should validate_presence_of(:field) }

    context 'When field is input_text' do
      it 'Should validates absence of text' do
        component = build(:component, field: 'input_text', text: 'some text')
        expect(component.valid?).to be_falsey
        expect(component.errors[:text]).to include('must be blank')
      end
    end

    context 'When field is not input_text' do
      it 'Should not validate absence of text' do
        component = build(:component, field: 'label', text: 'some text')
        expect(component.valid?).to be_truthy
      end
    end
  end
end
