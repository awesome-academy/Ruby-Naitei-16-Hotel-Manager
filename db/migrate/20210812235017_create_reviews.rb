class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :commentable, polymorphic: true, null: false
      t.text :comment
      t.float :rating, default: 0
      t.timestamps
    end
    add_index :reviews, [:commentable_id, :commentable_type]
  end
end
