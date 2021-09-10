class RemoveResetPasswordFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :reset_sent_at, :datetime
    remove_column :users, :reset_password_token, :datetime
    remove_column :users, :reset_digest, :datetime
    remove_column :users, :reset_password_sent_at, :datetime
  end
end
