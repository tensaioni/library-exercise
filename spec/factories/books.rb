FactoryBot.define do
  factory :book do
    title { "Sample Book Title" }
    author { "Sample Author" }
    sequence(:serial_number) { |n| format('%06d', n) }
  end
end
