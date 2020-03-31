class CreateProductsSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :products_sizes do |t|
      t.references :product, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
    end
  end
end
