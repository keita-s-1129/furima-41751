FactoryBot.define do
  factory :item do
    title              { Faker::Name.initials(number: 2) }
    description        { Faker::Lorem.sentence }
    category_id        { 2 }
    condition_id       { 2 }
    shipping_fee_id    { 2 }
    prefecture_id      { 2 }
    delivery_day_id    { 2 }
    price              { 1000 }

    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end
