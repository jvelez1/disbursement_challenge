class CreateDisbursements < ActiveRecord::Migration[6.1]
  def change
    create_table :disbursements do |t|
      t.belongs_to :merchant, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.float      :fee, null: :false
      t.decimal    :total, precision: 16, scale: 2, null: :false

      t.index [:merchant_id, :order_id], unique: true
      t.timestamps
    end
  end
end
