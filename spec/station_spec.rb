require 'station'

describe Station do

  subject { described_class.new(name: "Old Street", zone: 1) }

  it "knows its name" do
    expect(subject.name).to eq("Old Street")
  end

  it "stores the station's zone" do
    expect(subject.zone).to eq(1)
  end

end
