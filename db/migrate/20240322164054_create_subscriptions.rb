class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :following, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :subscriptions, %i[follower_id following_id], unique: true
  end
end
