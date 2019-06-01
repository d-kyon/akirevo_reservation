class CreateSeminarUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :seminar_users do |t|
      t.references :user
      t.references :seminar
      t.timestamps
    end
  end
end
