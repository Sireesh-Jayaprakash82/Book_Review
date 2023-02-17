class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.integer :cost
      t.integer :pages
      t.timestamps
    end
  end
end
