class CreatePaymentRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_requests do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :bill_total, default: 0

      t.timestamps
    end
  end
end
