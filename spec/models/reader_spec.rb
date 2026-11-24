require "rails_helper"

RSpec.describe Reader, type: :model do
  it { is_expected.to have_many(:leases) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:library_card_number) }

  describe "validations" do
    it { expect(build_stubbed(:reader)).to be_valid }
    it { expect(build_stubbed(:reader, name: nil)).to_not be_valid }
    it { expect(build_stubbed(:reader, email: nil)).to_not be_valid }
    it { expect(build_stubbed(:reader, email: "invalid_email")).to_not be_valid }
    it { expect(build_stubbed(:reader, library_card_number: "1234567")).to_not be_valid }
    it { expect(build_stubbed(:reader, library_card_number: "1234")).to_not be_valid }
    it { expect(build_stubbed(:reader, library_card_number: nil)).to_not be_valid }
    it { expect(build_stubbed(:reader, library_card_number: "1234abc")).to_not be_valid }
  end
end
