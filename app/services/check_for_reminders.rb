class CheckForReminders < ApplicationService
  def initialize
  end

  def call
    not_returned_leases = Lease.where(returned_at: nil)

    long_cutoff_days = LEASE_TERM_DAYS - LONG_REMINDER_DAYS
    long_cutoff_date = long_cutoff_days.days.ago.beginning_of_day..long_cutoff_days.days.ago.end_of_day
    short_cutoff_days = LEASE_TERM_DAYS - SHORT_REMINDER_DAYS
    short_cutoff_date = ..short_cutoff_days.days.ago.end_of_day

    not_returned_leases.where(created_at: long_cutoff_date).each do |lease|
      ReminderMailer.long_reminder(lease: lease).deliver_later
    end

    not_returned_leases.where(created_at: short_cutoff_date).each do |lease|
      ReminderMailer.short_reminder(lease: lease).deliver_later
    end
  end
end
