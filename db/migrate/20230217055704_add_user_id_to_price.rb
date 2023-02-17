class AddUserIdToPrice < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :user_id, :integer
  end
end
