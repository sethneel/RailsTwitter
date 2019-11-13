class CreateFollowerships < ActiveRecord::Migration[6.0]
  def change
    create_table :followerships do |t|
      t.references :follower_user, null: false
      t.references :followed_user, null: false
      t.timestamps
    end
    
    add_foreign_key :followerships, :users, column: :follower_user_id, name: :follower_index
    add_foreign_key :followerships, :users, column: :followed_user_id, name: :followed_index
  end
end

