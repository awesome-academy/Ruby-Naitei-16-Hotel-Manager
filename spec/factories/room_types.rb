FactoryBot.define do
  factory :room_type do
    name {Faker::Name.name}
    description {Faker::Lorem.sentence}
    bed_num {1}
    cost {100}
  end
end
