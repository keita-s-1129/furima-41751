FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { 'password123' }
    password_confirmation { password }
    first_name            { '太郎' }
    last_name             { '山田' }
    first_kana            { 'タロウ' }
    last_kana             { 'ヤマダ' }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
