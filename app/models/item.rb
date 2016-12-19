class Item < ApplicationRecord
  validates_presence_of :name, :price

  belongs_to :collection, optional: true
end
