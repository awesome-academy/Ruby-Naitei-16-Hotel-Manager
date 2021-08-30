FactoryBot.define do
  factory :booking do
    association :user, factory: :user
    association :room, factory: :room
    checkin {DateTime.now + 1.day}
    checkout {DateTime.now + 2.day}
  end
end
