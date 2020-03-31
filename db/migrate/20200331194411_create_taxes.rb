class CreateTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :taxes do |t|
      t.string :name
      t.decimal :tax
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
