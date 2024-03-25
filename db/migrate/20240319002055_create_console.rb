class CreateConsole < ActiveRecord::Migration[7.1]
  def change
    create_table :consoles do |t|
      t.string :name
      t.integer :price
      t.boolean :available

      t.timestamps
    end
  end
end
