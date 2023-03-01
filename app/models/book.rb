class Book < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :comments
    has_one :price
    accepts_nested_attributes_for :price

end
