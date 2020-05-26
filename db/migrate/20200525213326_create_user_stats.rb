class CreateUserStats < ActiveRecord::Migration[6.0]
  def change
    create_table :user_stats do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :right_streak, default: 0
      t.integer :wrong_streak, default: 0
      t.integer :max_right_streak, default: 0
      t.integer :max_wrong_streak, default: 0

      t.timestamps
    end
  end
end
