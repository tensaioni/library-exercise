class LeaseSerializer
  include JSONAPI::Serializer

  attributes :returned_at

  attribute :leased_at do |object|
    object.created_at
  end

  belongs_to :reader
end
