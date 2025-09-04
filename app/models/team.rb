class Team < ApplicationRecord
  has_one :wallet, as: :entityable, dependent: :destroy

  validates :name, presence: true
end
