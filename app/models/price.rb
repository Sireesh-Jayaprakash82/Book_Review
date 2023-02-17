class Price < ApplicationRecord
    belongs_to :book, optional:true
end
