FactoryBot.define do
  factory :room do
    room_number {Faker::Number.decimal_part(digits: 4)}
    description {Faker::Lorem.sentence}
    association :room_type
  end
end
