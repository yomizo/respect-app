FactoryBot.define do
  factory :user do
    name "Yomiyama"
    sequence(:email) { |n| "tester#{n}@yomiyama.com"}
    password "yomiyamapass"
  end
end
