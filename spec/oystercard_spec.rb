require 'oystercard'

describe Oystercard do

  describe "#balance" do
    it "displays balance on Oystercard" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "tops up an Oystercard's balance from 0 to 1" do
    # Our first test:
      # subject.top_up(1)
      # expect(subject.balance).to eq 1
    # This test will pass regardless of @balance's initial value:
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "raises an error if user attempts to top up balance past a limit" do
      oyster = Oystercard.new
      oyster.top_up(Oystercard::BALANCE_LIMIT)
      expect {oyster.top_up(1)}.to raise_error("maximum limit = #{Oystercard::BALANCE_LIMIT}")
    end
  end

  describe "#deduct" do
    it "deducts an amount from the Oystercard's balance" do
      oyster = Oystercard.new
      oyster.top_up(10)
      expect{ oyster.deduct(5) }.to change{ oyster.balance }.by -5
    end
  end

  describe "#in_journey?" do
    context "when not touched in" do
      it "returns false" do
        oyster = Oystercard.new
        expect(oyster).not_to be_in_journey
      end
    end
  end

end
