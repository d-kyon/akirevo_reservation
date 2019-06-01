class SeminarUser < ApplicationRecord
  belongs_to :user
  belongs_to :seminar
end
