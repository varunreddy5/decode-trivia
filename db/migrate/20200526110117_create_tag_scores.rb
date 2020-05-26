class CreateTagScores < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_scores do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
