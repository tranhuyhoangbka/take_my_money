class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.float :price
      t.integer :status
      t.string :reference
      t.string :payment_method
      t.string :response_id
      t.json :full_response

      t.timestamps
    end
  end
end
