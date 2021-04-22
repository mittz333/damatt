FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    category_id { Faker::Number.between(from: 11, to: 99) }
    detail { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    location_id { Faker::Number.between(from: 1, to: 10) }
    department_id { Faker::Number.between(from: 11, to: 99) }
    purchase_date { Date.new(2021, 2, 24) }
    control_number { Faker::Lorem.word }
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    association :member
  end
end
