require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :request do
  context "GET /api/v1/books" do
    before do
      @book = create(:book)
    end

    it "returns a list of books" do
      get api_v1_books_path
      expected_json = { "data" => [{"attributes" => {"author" => @book.author, "available?" => true, "serial_number" => @book.serial_number, "title" => @book.title}, "id" => @book.serial_number, "type" => "book"}] }
      expect(json_response).to include(expected_json)
    end

    it "responds with a success" do
      get api_v1_books_path
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /api/v1/books" do
    it "creates a new book" do
      expect {
        post api_v1_books_path, params: { title: "New Book", author: "New Author", serial_number: "123456" }
      }.to change(Book, :count).by(1)
    end

    it "responds with a success" do
      post api_v1_books_path, params: { title: "New Book", author: "New Author", serial_number: "123456" }
      expect(response).to have_http_status(:created)
    end

    it "fails to create a book with invalid parameters" do
      post api_v1_books_path, params: { title: "", author: "", serial_number: "" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "GET /api/v1/books/:id" do
    before do
      @book = create(:book)
    end

    it "returns a book" do
      get api_v1_book_path(@book.serial_number)
      expected_json = { "data" => {"attributes" => {"author" => @book.author, "serial_number" => @book.serial_number, "title" => @book.title}, "id" => @book.serial_number, "relationships" => {"leases" => {"data" => []}}, "type" => "book_history"}, "included" => [] }

      expect(json_response).to include(expected_json)
    end

    it "responds with a success" do
      get api_v1_book_path(@book.serial_number)
      expect(response).to have_http_status(:ok)
    end
  end

  context "DELETE /api/v1/books/:id" do
    before do
      @book = create(:book)
    end

    it "deletes a book" do
      expect {
        delete api_v1_book_path(@book.serial_number)
      }.to change(Book, :count).by(-1)
    end

    it "responds with a success" do
      delete api_v1_book_path(@book.serial_number)
      expect(response).to have_http_status(:accepted)
    end
  end

  context "POST /api/v1/books/:id/borrow" do
    before do
      @book = create(:book)
      @reader = create(:reader)
    end

    it "calls BorrowBook service" do
      expect(BorrowBook).to receive(:call).with(book: @book, reader: @reader)
      post borrow_api_v1_book_path(@book.serial_number), params: { library_card_number: @reader.library_card_number }
    end
  end

  context "PATCH /api/v1/books/:id/return" do
    before do
      @book = create(:book)
    end

    it "calls ReturnBook service" do
      expect(ReturnBook).to receive(:call).with(book: @book)
      patch return_api_v1_book_path(@book.serial_number)
    end
  end
end
