class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.references :question, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :correct, null: false, default: false

      t.timestamps
    end
  end
end
