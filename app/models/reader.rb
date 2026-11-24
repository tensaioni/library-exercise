class Reader < ApplicationRecord
  has_many :leases, dependent: :destroy

  validates :library_card_number, presence: true, uniqueness: true, format: { with: /\A\d{6}\z/, message: "must be an 6-digit number" }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
