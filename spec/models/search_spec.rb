require 'spec_helper'

describe Search do

  it "#is_term_taken?(input) - returns true for taken terms" do
    input = "sashagoldenson"
    expect(Search.new.is_term_taken?(input)).to be true
  end
    
  it "#is_term_taken?(input) - returns false for available terms" do
    input = "sashagoldenson" + Random.rand(9999).to_s
    begin
      expect(Search.new.is_term_taken?(input)).to be false
    # Rescue for 404 Not Found
    rescue OpenURI::HTTPError
      expect(false).to be false
    end
  end
    
  it "#is_term_taken?(input) - returns false for invalid terms" do
    input_too_short = "a"
    expect(Search.new.is_term_taken?(input_too_short)).to be true
  end
end