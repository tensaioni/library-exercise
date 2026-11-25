class ReturnBook < ApplicationService
  def initialize(book:)
    @book = book
  end

  def call
    lease = @book.leases.last
    lease.update(returned_at: Time.current)
  end
end
