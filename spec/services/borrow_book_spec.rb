require 'rails_helper'

RSpec.describe BorrowBook, type: :service do
  describe "#call" do
    let(:book) { create(:book) }
    let(:reader) { create(:reader) }

    it "create a lease for the book" do
      expect {
        BorrowBook.call(book: book, reader: reader)
      }.to change(Lease, :count).by(1)

      lease = Lease.last
      expect(lease.book).to eq(book)
      expect(lease.reader).to eq(reader)
      expect(lease.returned_at).to be_nil
    end
  end
end
