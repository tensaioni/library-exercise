class BorrowBook < ApplicationService
  def initialize(book:, reader:)
    @book = book
    @reader = reader
  end

  def call
    Lease.create!(book: @book, reader: @reader)
  end
end
