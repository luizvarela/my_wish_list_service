require 'representable/json'

class V1::CollectionsSerializer < Representable::Decorator
  include Representable::JSON

  property :name
end
