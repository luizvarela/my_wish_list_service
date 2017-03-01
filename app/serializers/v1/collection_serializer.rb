require 'representable/json'

class V1::CollectionSerializer < Representable::Decorator
  include Representable::JSON

  property :id
  property :name

  collection :items
end
