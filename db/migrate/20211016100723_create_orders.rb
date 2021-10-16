class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :merchant, foreign_key: true
      t.belongs_to :shopper, foreign_key: true
      t.decimal    :amount, precision: 16, scale: 2
      t.datetime   :completed_at
      t.timestamps
    end
  end
end
