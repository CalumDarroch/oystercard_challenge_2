require 'journey'

# responsible for:
#   starting a journey,
#   finishing a journey,
#   calculating the fare of a journey,
#   returning whether or not the journey is complete.

describe Journey do

  let(:station) { double :station }

  subject { described_class.new(station) }

  describe "#initialize" do
    it "records the entry station upon creation of a Journey object" do
      expect(subject.journey).to eq( {entry: station} )
    end
  end

  it { is_expected.to respond_to(:start_journey).with(1).argument }

  describe "#start_journey" do
    it "records the entry station for a journey" do
      expect(subject.start_journey("Old Street")).to eq( {entry: "Old Street"} )
    end
  end

  it { is_expected.to respond_to(:end_journey).with(1).argument }

  describe "#end_journey" do
    it "records the exit station for a journey" do
      subject.start_journey("Old Street")
      expect(subject.end_journey("Farringdon")).to eq( {entry: "Old Street", exit: "Farringdon"} )
    end
  end

  describe "#journey_complete?" do
    xit "should return an incomplete journey if there is no entry station" do
      subject.end_journey("Farringdon")
      expect(subject.journey_complete?).to eq false
    end
    it "should return an incomplete journey if there no exit station" do
      subject.start_journey("Old Street")
      expect(subject.journey_complete?).to eq false
    end
  end

  describe "#fare" do
    it "should return a minimum fare for a complete journey" do
      allow(subject).to receive(:journey_complete?).and_return true
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
    it "should charge a penalty fare for an incomplete journey" do
      allow(subject).to receive(:journey_complete?).and_return false
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

end
