FactoryBot.define do
  factory :reader do
    sequence(:library_card_number) { |n| format('%06d', n) }
    name { "Sample Reader Name" }
    sequence(:email) { |n| "sample#{n}@example.com" }
  end
end
