class Book < ApplicationRecord
  has_many :leases, dependent: :destroy
  has_many :open_leases, -> { where(returned_at: nil) }, class_name: "Lease"

  validates :serial_number, presence: true, uniqueness: true, format: { with: /\A\d{6}\z/, message: "must be a 6-digit number" }
  validates :title, presence: true
  validates :author, presence: true

  def available?
    open_leases.empty?
  end
end
