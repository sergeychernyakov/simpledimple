class CreateBillingDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_details do |t|
      t.references :payment_request
      t.references :user
      t.decimal :per_head, default: 0
      t.string :link
      t.string :phone, null: false

      t.timestamps
    end
  end
end
