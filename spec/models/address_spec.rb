require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should belong_to(:person) }

  it { is_expected.to validate_presence_of(:line1) }
  it { is_expected.to validate_presence_of(:line2) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:zip) }

  describe "#update" do
    before { @address = create(:address) }

    it "will update successfully with the right attributes" do
      @address.update(line1: "New address line1", line2: "New APT number")

      expect(@address.reload.line1).to eql "New address line1"
      expect(@address.reload.line2).to eql "New APT number"
    end

    it "will not update with the wrong attributes" do
      expect(@address.update(line1: "")).to eql false
    end
  end
end
