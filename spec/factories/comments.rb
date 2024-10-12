FactoryBot.define do
  factory :comment do
    content { FFaker::Lorem.phrase.truncate(199) }
    user
    post
  end
end
