FactoryBot.define do
  factory :user do
    sequence :email do |n|
      'tester-' + Random::rand(99999999).to_s + '@lmrtfy.com'
    end
    password 'tester'
  end
end