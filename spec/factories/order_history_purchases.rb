require "date"

FactoryBot.define do
  factory :order_history_purchase do
    address_number    {Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4)}
    delivery_area_id  {Faker::Number.between(from: 1, to: 47)}
    address_middle    {Gimei.address.city.kanji}
    address_bottom    {Gimei.address.town.kanji}
    address_detail    {Faker::Address.building_number}
    phone_number      {Faker::Number.number(digits: 10)}
    token             {'tok_' + Faker::Alphanumeric.alpha(number: 10) + Faker::Number.leading_zero_number(digits: 17)}
  end
end
