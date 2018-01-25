FactoryBot.define do
  factory :user do
    email 'tester-' + Random::rand(99999999).to_s + '@lmrtfy.com'
    password 'tester'
  end
end