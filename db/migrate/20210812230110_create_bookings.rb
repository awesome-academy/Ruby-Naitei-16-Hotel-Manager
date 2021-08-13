class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :booking_date
      t.datetime :checkin
      t.datetime :checkout

      t.timestamps
    end
  end
end
