class Component < ApplicationRecord
  enum :field, { label: "label", input_text: "input_text" }
  belongs_to :survey
end
