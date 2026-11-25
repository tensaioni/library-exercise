require 'rails_helper'

RSpec.describe ReturnBook, type: :service do
  describe "#call" do
    let(:book) { create(:book) }
    let!(:lease) { create(:lease, book: book, reader: create(:reader)) }


    it "updates the returned_at attribute of the last lease" do
      expect {
        ReturnBook.new(book: book).call
}.to change { lease.reload.returned_at }.from(nil).to be_within(1.second).of(Time.current)
    end
  end
end
