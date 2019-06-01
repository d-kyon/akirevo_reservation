class CreateSeminars < ActiveRecord::Migration[5.2]
  def change
    create_table :seminars do |t|
      t.string :title
      t.datetime :date
      t.string :address
      t.integer :max
      t.timestamps
    end
  end
end
