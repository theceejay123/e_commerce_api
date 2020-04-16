class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :phone_number
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
