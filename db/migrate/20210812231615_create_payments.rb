class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.float :amount
      t.datetime :payment_date
      t.boolean :is_paid, default: false

      t.timestamps
    end
  end
end
