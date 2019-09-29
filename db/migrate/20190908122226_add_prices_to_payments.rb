class AddPricesToPayments < ActiveRecord::Migration[5.2]
  def change
    change_table :payments do |t|
      t.json :partials
    end
  end
end
