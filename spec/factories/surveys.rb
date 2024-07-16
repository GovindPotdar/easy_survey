FactoryBot.define do
  factory :survey do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
  end
end
