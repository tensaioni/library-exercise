class Lease < ApplicationRecord
  belongs_to :book
  belongs_to :reader

  validates :book_id, presence: true
  validates :reader_id, presence: true
end
