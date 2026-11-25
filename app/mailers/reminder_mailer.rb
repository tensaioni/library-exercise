class ReminderMailer < ApplicationMailer
  def long_reminder(lease:)
    @book = lease.book
    @reader = lease.reader

    subject = if LONG_REMINDER_DAYS.zero?
                "Your book is due today!"
              else
                "Your book is due in #{LONG_REMINDER_DAYS} days!"
              end

    mail(to: @reader.email, subject: subject)
  end

  def short_reminder(lease:)
    @book = lease.book
    @reader = lease.reader

    subject = if SHORT_REMINDER_DAYS.zero?
                "Your book is due today!"
              else
                "Your book is due in #{SHORT_REMINDER_DAYS} days!"
              end

    mail(to: @reader.email, subject: subject)
  end
end
