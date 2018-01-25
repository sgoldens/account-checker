FactoryBot.define do
  # factory :user do
  #   email 'tester-searches@lmrtfy.com'
  #   password  'tester'
  # end

  factory :search do
    user
    term 'sashagoldenson'
  end
end