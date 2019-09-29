class AddShippingMethodToPurchase < ActiveRecord::Migration[5.2]
  def change
    change_table :payments do |t|
      t.integer :shipping_method, default: 0
    end
  end
end
