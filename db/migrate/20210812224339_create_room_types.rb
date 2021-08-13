class CreateRoomTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :room_types do |t|
      t.string :name
      t.float :cost
      t.integer :bed_num
      t.boolean :air_conditioner
      t.text :description

      t.timestamps
    end
  end
end
