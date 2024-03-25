class CreateGame < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :year_released
      t.boolean :age_verification
      t.references :console, null: false, foreign_key: true

      t.timestamps
    end
  end
end
