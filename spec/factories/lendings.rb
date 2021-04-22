FactoryBot.define do
  factory :lending do

    starttime { Date.new(2021, 2, 24) }
    finishtime { Date.new(2021, 2, 24) }

    association :member
    association :item

  end
end
