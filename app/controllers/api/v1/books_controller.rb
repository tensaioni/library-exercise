class Api::V1::BooksController < ApplicationController
  def index
    books_json = BookSerializer.new(Book.includes(:open_leases)).serializable_hash.to_json
    render json: books_json
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      book_json = BookSerializer.new(@book).serializable_hash.to_json
      render json: book_json, status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @book = Book.find_by(serial_number: params[:id])
    book_json = BookHistorySerializer.new(@book, include: [:leases, :'leases.reader']).serializable_hash.to_json

    render json: book_json
  end

  def destroy
    @book = Book.find_by(serial_number: params[:id])

    @book.destroy
    head :accepted
  end

  def borrow
    @book = Book.find_by(serial_number: params[:id])
    @reader = Reader.find_by(library_card_number: params[:library_card_number])

    BorrowBook.call(book: @book, reader: @reader)

    head :ok
  end

  def return
    @book = Book.find_by(serial_number: params[:id])

    ReturnBook.call(book: @book)

    head :ok
  end

  private

  def book_params
    params.permit(:title, :author, :serial_number)
  end
end
