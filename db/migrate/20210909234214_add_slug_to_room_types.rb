class AddSlugToRoomTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :room_types, :slug, :string
  end
end
