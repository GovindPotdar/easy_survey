class Component < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :survey  
  enum :field, {label: "label", input_text: "input_text"}

  validates :x_axis, :y_axis, :field, presence: true
  validates :text, absence: true, if: ->{ field == Component.fields[:input_text] }
end
