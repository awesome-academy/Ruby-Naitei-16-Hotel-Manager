class AddSlugToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :slug, :string
  end
end
