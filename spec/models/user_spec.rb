require 'spec_helper'

RSpec.describe User, :type => :model do
  describe '#validations' do

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should have_many(:searches) }

    #TODO other devise validations
  end

  it "has a valid factory" do
    expect(FactoryBot.build(:user).save).to be true
  end

  it "is invalid without an email" do
    expect(FactoryBot.build(:user, email: nil).save).to be false
  end

  it "is invalid without an password" do
    expect(FactoryBot.build(:user, password: nil).save).to be false
  end

  it "is invalid without a unique email" do
    expect(FactoryBot.build(:user).save).to be true
    expect(FactoryBot.build(:user).save).to be false
  end

end