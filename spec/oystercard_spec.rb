require 'oystercard'

describe Oystercard do

  let(:station) { double :station }

  describe "#initialize" do
    it "creates an oystercard with an empty journey history" do
      oyster = Oystercard.new
      expect(oyster.journey_history).to be_empty
    end
  end

  describe "#balance" do
    it "displays balance on Oystercard" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "tops up an Oystercard's balance from 0 to 1" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "raises an error if user attempts to top up balance past a limit" do
      oyster = Oystercard.new
      oyster.top_up(Oystercard::BALANCE_LIMIT)
      expect {oyster.top_up(1)}.to raise_error("maximum limit = #{Oystercard::BALANCE_LIMIT}")
    end
  end

  describe "#in_journey?" do
    context "when new oystercard is generated it is not in journey" do
      it "returns false" do
        oyster = Oystercard.new
        expect(oyster).not_to be_in_journey
      end
    end
  end

  describe "#touch_in" do
    context "when touched in" do
      it "in journey returns true" do
        oyster = Oystercard.new
        oyster.top_up(10)
        oyster.touch_in(station)
        expect(oyster).to be_in_journey
      end
    end

    context "when balance is below minimum balance" do
      it "raises an error" do
        oyster = Oystercard.new
        expect { oyster.touch_in(station) }.to raise_error "Balance below minimum"
      end
    end

    context "when touching in at a station" do
      it "records the station name it touched in at" do
        oyster = Oystercard.new
        oyster.top_up(10)
        expect(oyster.touch_in(station)).to eq( { entry: station } )
      end
    end
  end

  describe "#touch_out" do
    context "when touched out" do
      it "in journey returns false" do
        oyster = Oystercard.new
        oyster.top_up(10)
        oyster.touch_in(station)
        oyster.touch_out(station)
        expect(oyster).not_to be_in_journey
      end
    end
    context "when touching out" do
      it "some money is deducted from balance" do
        oyster = Oystercard.new
        oyster.top_up(10)
        oyster.touch_in(station)
        expect { oyster.touch_out(station) }.to change{ oyster.balance }.by(-Oystercard::MINIMUM_CHARGE)
      end
      it "records the exit station" do
        oyster = Oystercard.new
        oyster.top_up(10)
        oyster.touch_in(station)
        expect(oyster.touch_out(station)).to eq( [{ entry: station, exit: station}] )
      end
    end
  end

end
