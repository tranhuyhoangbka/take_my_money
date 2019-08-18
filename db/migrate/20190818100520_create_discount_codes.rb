class CreateDiscountCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.integer :percentage
      t.text :description
      t.integer :minimum_amount
      t.integer :maximum_discount
      t.integer :max_uses

      t.timestamps
    end

    change_table :payments do |t|
      t.references :discount_code
      t.integer :discount
    end
  end
end
