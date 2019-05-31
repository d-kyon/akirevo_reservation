class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      #アカウント作成時の情報
      t.string "line_id"
      t.string "name"
      t.boolean "name_is" , default: 0
      t.string "name_kana"
      t.boolean "name_kana_is" , default: 0
      t.string "email"
      t.boolean "email_is" , default: 0
      t.string "phone_number" #半角11桁
      t.boolean "phone_number_is" , default: 0
      t.string "introduction_code" #招待コード
      t.boolean "introduction_code_is" , default: 0
      t.text "self"
      t.boolean "self_is" , default: false
    end
  end
end
