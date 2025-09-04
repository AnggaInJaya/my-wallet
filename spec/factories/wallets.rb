FactoryBot.define do
  factory :wallet do
    trait :for_user do
      association :entityable, factory: :user
      balance { 100 }
    end

    trait :for_team do
      association :entityable, factory: :team
      balance { 0 }
    end
  end
end