class BookHistorySerializer
  include JSONAPI::Serializer

  set_id :serial_number
  attributes :title, :author, :serial_number

  has_many :leases, serializer: ::LeaseSerializer
end
