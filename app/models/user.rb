class User < ApplicationRecord
  has_many :refresh_tokens, dependent: :delete_all
  has_one :wallet, as: :entityable, dependent: :destroy

  validates :email, presence: true, uniqueness: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }

  has_secure_password

  after_create_commit :add_wallet

  def add_wallet
    self.create_wallet
  end
end
