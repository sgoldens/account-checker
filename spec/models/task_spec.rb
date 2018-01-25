require 'spec_helper'

describe Task, :type => :model do

  describe '#validations' do

    it { should validate_presence_of(:task) }
    it { should belong_to(:user) }

  end

  it "has a valid factory" do
    expect(FactoryBot.build(:task).save).to be true
  end

  it "is invalid without a task" do
    expect(FactoryBot.build(:task, task: nil).save).to be false
  end

end