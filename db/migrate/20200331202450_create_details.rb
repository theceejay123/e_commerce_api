class CreateDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :details do |t|
      t.decimal :price
      t.integer :quantity
      t.references :order_detail, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
