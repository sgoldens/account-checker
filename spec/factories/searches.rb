FactoryBot.define do
  factory :search do
    term 'tester' + Random::rand(99999999).to_s
  end
end