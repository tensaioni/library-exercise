require 'rails_helper'

RSpec.describe CheckForReminders, type: :service do
  let(:book) { create(:book) }
  let(:reader) { create(:reader) }

  subject(:service_call) { CheckForReminders.call }

  describe "#call" do

    context "when there's a book due today" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 30.days.ago) }

      it "calls the correct mailer" do
        expect(ReminderMailer).to receive(:short_reminder)
        expect(ReminderMailer).not_to receive(:long_reminder)

        service_call
      end
    end

    context "when there's a book due in two days" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 28.days.ago) }

      it "calls the correct mailer" do
        expect(ReminderMailer).not_to receive(:short_reminder)
        expect(ReminderMailer).not_to receive(:long_reminder)

        service_call
      end
    end

    context "when there's a book due in three days" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 27.days.ago) }

      it "calls the correct mailer" do
        expect(ReminderMailer).not_to receive(:short_reminder)
        expect(ReminderMailer).to receive(:long_reminder)

        service_call
      end
    end

    context "when there's a book due in a week" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 23.days.ago) }

      it "calls the correct mailer" do
        expect(ReminderMailer).not_to receive(:short_reminder)
        expect(ReminderMailer).not_to receive(:long_reminder)

        service_call
      end
    end

    context "when a book is overdue" do
      let!(:lease) { create(:lease, book: book, reader: reader, created_at: 1.year.ago) }

      it "calls the correct mailer" do
        expect(ReminderMailer).to receive(:short_reminder)
        expect(ReminderMailer).not_to receive(:long_reminder)

        service_call
      end
    end
  end
end
