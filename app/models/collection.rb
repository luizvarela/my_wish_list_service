class Collection < ApplicationRecord
  validates_presence_of :name

  has_many :items
  accepts_nested_attributes_for :items, allow_destroy: true
end
