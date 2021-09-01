FactoryBot.define do
  factory :payment do
    association :user, factory: :user
    amount {100.0}
  end
end
