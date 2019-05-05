FactoryBot.define do
  factory :metoo do
    association :user
    association :post
  end
end
