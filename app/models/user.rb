class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :rooms, through: :bookings
  has_many :reviews, as: :commentable, dependent: :destroy

  enum gender: {female: 0, male: 1}

  validates :name, presence: true,
                   length: {maximum: Settings.validation.name.length.max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email.length.max},
            format: {with: Settings.validation.email.valid_regex},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.validation.password.length.min},
            allow_nil: true
  validates :phone, length: {is: Settings.validation.phone.length}

  has_secure_password
end
