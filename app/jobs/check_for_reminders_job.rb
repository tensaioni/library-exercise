class CheckForRemindersJob < ApplicationJob
  def perform
    CheckForReminders.call
  end
end
