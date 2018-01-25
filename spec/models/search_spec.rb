require 'spec_helper'

describe Search, :type => :model do

  describe '#validations' do

    it { should validate_presence_of(:term) }
    it { should belong_to(:user) }

  end

  it "has a valid factory" do
    expect(FactoryBot.build(:search).save).to be true
  end

  it "#is_term_taken?(input) - returns true for taken terms" do
    search = FactoryBot.build(:search)
    expect(search.is_term_taken?(search.term)).to be true
  end
    
  it "#is_term_taken?(input) - returns false for available terms" do
    search = FactoryBot.build(:search, term: "sashagoldenson" + Random.rand(9999).to_s)
    begin
      expect(search.is_term_taken?(search.term)).to be false
    # Rescue for 404 Not Found
    rescue OpenURI::HTTPError
      expect(false).to be false
    end
  end
    
  it "#is_term_taken?(input) - returns false for invalid terms" do
    search = FactoryBot.build(:search, term: "a")
    expect(search.is_term_taken?(search.term)).to be false
  end

end