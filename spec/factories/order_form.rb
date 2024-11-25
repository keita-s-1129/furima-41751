FactoryBot.define do
  factory :order_form do
    post_code       { Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4) }
    prefecture_id   { 2 }
    city            { Faker::Address.city }
    address         { Faker::Address.street_address }
    phone_number    { Faker::Number.leading_zero_number(digits: 11) }
    token           { 'tok_abcdefghijk00000000000000000' }

    association :user_id
    association :item_id
  end
end