require 'station'

describe Station do

  describe "#name" do
    it "stores the station's name" do
      expect(subject).to respond_to(:name)
    end
  end

  describe "#zone" do
    it "stores the station's zone" do
      expect(subject).to respond_to(:name)
    end
  end

end
