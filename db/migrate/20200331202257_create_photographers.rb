class CreatePhotographers < ActiveRecord::Migration[6.0]
  def change
    create_table :photographers do |t|
      t.string :full_name
      t.text :description

      t.timestamps
    end
  end
end
