class CreateDayRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :day_revenues do |t|
      t.date :day
      t.integer :ticket_count
      t.integer :price
      t.integer :discounts

      t.timestamps
    end
  end
end
