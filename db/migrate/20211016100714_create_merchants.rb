class CreateMerchants < ActiveRecord::Migration[6.1]
  def change
    create_table :merchants do |t|
      t.string :name,               null: false, default: ''
      t.string :email,              null: false, index: { unique: true }
      t.string :cif,                null: false, index: { unique: true }
      t.timestamps
    end
  end
end
