require 'rails_helper'

RSpec.describe Survey, type: :model do

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should have_many(:components).dependent(:destroy) }
  end

  describe "acts_as_paranoid" do
    let!(:survey) { create(:survey) }

    it "Should soft deletes the survey" do
      survey.destroy
      expect(Survey.only_deleted).to include(survey)
    end
  end
end
