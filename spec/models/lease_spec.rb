require "rails_helper"

RSpec.describe Lease, type: :model do
  it { is_expected.to belong_to(:reader) }
  it { is_expected.to belong_to(:book) }

  it { is_expected.to validate_presence_of(:reader_id) }
  it { is_expected.to validate_presence_of(:book_id) }
end
