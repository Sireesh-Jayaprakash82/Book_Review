class AddBookIdToPrice < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :book_id, :integer
  end
end
