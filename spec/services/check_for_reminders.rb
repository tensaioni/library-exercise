require 'rails_helper'

RSpec.describe CheckForReminders, type: :service do
  describe "#call" do
    let(:book) { create(:book) }
    let(:reader) { create(:reader) }

    context "when there's a book due today" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 30.days.ago) }

      it "calls the correct mailer" do
        expect(CheckForRemindersMailer).to recieve(:short_reminder)
        expect(CheckForRemindersMailer).not_to recieve(:long_redminder)
      end
    end

    context "when there's a book due in two days" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 28.days.ago) }
        expect(CheckForRemindersMailer).not_to recieve(:short_reminder)
        expect(CheckForRemindersMailer).not_to recieve(:long_redminder)
    end

    context "when there's a book due in three days" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 27.days.ago) }
        expect(CheckForRemindersMailer).not_to recieve(:short_reminder)
        expect(CheckForRemindersMailer).to recieve(:long_redminder)
    end

    context "when there's a book due in a week" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 23.days.ago) }
        expect(CheckForRemindersMailer).not_to recieve(:short_reminder)
        expect(CheckForRemindersMailer).not_to recieve(:long_redminder)
    end

    context "when a book is overdue" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 1.year.ago) }
        expect(CheckForRemindersMailer).to recieve(:short_reminder)
        expect(CheckForRemindersMailer).not_to recieve(:long_redminder)
    end
  end
end
