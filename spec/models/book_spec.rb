require "rails_helper"

RSpec.describe Book, type: :model do
  it { is_expected.to have_many(:leases) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:serial_number) }

  describe "validations" do
    it { expect(build_stubbed(:book)).to be_valid }
    it { expect(build_stubbed(:book, title: nil)).to_not be_valid }
    it { expect(build_stubbed(:book, author: nil)).to_not be_valid }
    it { expect(build_stubbed(:book, serial_number: "1234567")).to_not be_valid }
    it { expect(build_stubbed(:book, serial_number: "1234")).to_not be_valid }
    it { expect(build_stubbed(:book, serial_number: nil)).to_not be_valid }
    it { expect(build_stubbed(:book, serial_number: "1234abc")).to_not be_valid }
  end
end
