class ReaderSerializer
  include JSONAPI::Serializer

  set_id :library_card_number
  attributes :name, :email, :library_card_number
end
