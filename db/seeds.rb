tester = User.create([{ email: 'tester@lmrtfy.com', password: 'tester'}])
p "tester@lmrtfy.com seed account created"

random_test_accounts = 50.times do
  User.create({ email: 'tester-' + Random::rand(99999999).to_s + '@lmrtfy.com', password: "tester"})
end
p "50 random tester-[random number]@lmrtfy.com seed account created"