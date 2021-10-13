require "date"

FactoryBot.define do
  factory :item do
    image             {Rack::Test::UploadedFile.new(File.join(Rails.root,'app/assets/images/マホイップ.png'))}
    title             {Faker::Alphanumeric.alphanumeric(number:10)}
    explanation       {Faker::Alphanumeric.alphanumeric(number:100)}
    category_id       {Faker::Number.between(from: 1, to: 10)}
    status_id         {Faker::Number.between(from: 1, to: 6)}
    delivery_fee_id   {Faker::Number.between(from: 1, to: 2)}
    delivery_area_id  {Faker::Number.between(from: 1, to: 47)}
    delivery_day_id   {Faker::Number.between(from: 1, to: 3)}
    price             {Faker::Number.between(from: 300, to: 9999999)}
    association       :user
  end
end