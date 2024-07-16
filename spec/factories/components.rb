FactoryBot.define do
  factory :component do
    association :survey
    
    field { 'label' }
    text { Faker::Lorem.sentence }
    x_axis { Faker::Number.decimal(l_digits: 2) }
    y_axis { Faker::Number.decimal(l_digits: 2) }
  end
end
