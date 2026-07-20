class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.date :date
      t.time :time
      t.text :comment

      t.timestamps
    end
    add_index :events, :date
  end
end
