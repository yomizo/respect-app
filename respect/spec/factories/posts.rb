FactoryBot.define do
  factory :post do
    respect "thanks"
    lat 35.4321
    lng 129.4324
    comment "initial comment initial comment initial comment initial comment"
    association :user
  end
end
