class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :book
    scope :find_comments, ->(name) { where("name = ?", name) }
end