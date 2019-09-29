class CreateAffiliates < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliates do |t|
      t.string :name
      t.integer :user_id
      t.string :country
      t.string :stripe_id
      t.string :tag
      t.json :verification_needed
      t.timestamps
    end

    change_table :payments do |t|
      t.integer :affiliate_id
      t.integer :affiliate_payment_cents, default: 0, null: false
      t.string  :affiliate_payment_currency, default: "USD", null: false
    end

    change_table :shopping_carts do |t|
      t.integer :affiliate_id
    end
  end
end
