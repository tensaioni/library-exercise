class BookSerializer
  include JSONAPI::Serializer

  set_id :serial_number
  attributes :title, :author, :serial_number, :available?
end
