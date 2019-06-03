class Seminar < ApplicationRecord
  has_many :seminar_users, dependent: :destroy
end
