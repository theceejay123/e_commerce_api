class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.integer :reference_number
      t.decimal :total
      t.decimal :historical_tax
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
