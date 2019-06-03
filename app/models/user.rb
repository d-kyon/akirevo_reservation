class User < ApplicationRecord
  has_many :seminar_users, dependent: :destroy
end
