FactoryBot.define do
  factory :member do
    name { Faker::Name.last_name }
    email { Faker::Internet.free_email }

    password { Faker::Lorem.characters(number: 10, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }

    department_id { 111 }
  end
end
