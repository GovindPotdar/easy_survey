require 'rails_helper'

RSpec.describe BulkUpdateComponents do
  let(:survey) { create(:survey) }

  def prepare_component_param(component)
    {
      text: component.text,
      x_axis: component.x_axis,
      y_axis: component.y_axis,
      field: component.field,
      id: component.id
    }
  end

  describe '.call' do

    before do
      # State 1
      @component1 = create(:component, survey: survey, field: "label") 

      # State 2
      # component1
      @component2 = create(:component, survey: survey) 

      #State 3
      # component1
      # component2
      @component3 = create(:component, survey: survey) 

      # State 4
      @component1.update(text: "some text")
      # component2
      # component3

      #State 5 -> current state
      # component1
      # component2
      # component3
      @component4 = create(:component, survey: survey) 
    end


    it 'Should update or destroy components according to components data' do
      prev_components_data = [prepare_component_param(@component1), prepare_component_param(@component2), prepare_component_param(@component3)]

      expect(UpdateComponent).to receive(:call).with(survey, kind_of(Numeric), kind_of(Hash)).and_return({ status: :success }).exactly(3).times
      expect(DeleteComponent).to receive(:call).with(survey, kind_of(Numeric)).and_return({ status: :success })
      response = described_class.call(survey, prev_components_data)
      expect(response[:status]).to eq(:success)
      expect(response[:errors]).to be_empty
    end

    context "When an error occured" do
      it "Shoud return error" do
        prev_components_data = [prepare_component_param(@component1), prepare_component_param(@component2), prepare_component_param(@component3)]

        expect(UpdateComponent).to receive(:call).with(survey, kind_of(Numeric), kind_of(Hash)).and_return({ status: :success }).exactly(3).times
        expect(DeleteComponent).to receive(:call).with(survey, kind_of(Numeric)).and_return({ status: :failure, errors: ["some error"] })
        response = described_class.call(survey, prev_components_data)
        expect(response[:status]).to eq(:failure)
        expect(response[:errors]).to match_array(["some error"])
      end
    end
  end
end
