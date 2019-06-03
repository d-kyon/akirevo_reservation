class CreateSeminarUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :seminar_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :seminar, index: true, foreign_key: true
      t.timestamps
    end
  end
end
