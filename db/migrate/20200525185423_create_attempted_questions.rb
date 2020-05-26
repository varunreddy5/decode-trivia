class CreateAttemptedQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :attempted_questions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :user_answer

      t.timestamps
    end
  end
end
