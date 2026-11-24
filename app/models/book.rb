class Book < ApplicationRecord
  has_many :leases, dependent: :destroy

  validates :serial_number, presence: true, uniqueness: true, format: { with: /\A\d{6}\z/, message: "must be a 6-digit number" }
  validates :title, presence: true
  validates :author, presence: true

  def available?
    leases.where(returned_at: nil).empty?
  end
end
