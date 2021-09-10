class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  attr_accessor :remember_token

  extend FriendlyId
  friendly_id :name, use: :slugged

  before_save :downcase_email

  has_many :bookings, dependent: :destroy
  has_many :rooms, through: :bookings
  has_many :reviews, as: :commentable, dependent: :destroy
  has_many :payments, dependent: :destroy

  enum gender: {female: 0, male: 1}
  enum role: {customer: -1, staff: 0, admin: 1}
  PERMITTED = %i(name email gender phone password password_confirmation).freeze
  PERMITTED2 = %i(name email gender phone password
                  password_confirmation role).freeze

  validates :name, presence: true,
                   length: {maximum: Settings.validation.name.length.max}
  validates :email, presence: true,
            length: {maximum: Settings.validation.email.length.max},
            format: {with: Settings.validation.email.valid_regex},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.validation.password.length.min},
            allow_nil: true
  validates :phone, length: {is: Settings.validation.phone.length},
            allow_nil: true

  scope :customer, ->{where(role: :customer)}
  scope :new_user, (lambda do |month_ago|
    where("created_at >= ?", Time.zone.now - month_ago.months)
  end)
  scope :new_user_by_month, (lambda do
    group_by_month(
      :created_at,
      last: Settings.statistic.default.month_ago,
      format: "%b %Y"
    ).count
  end)

  private
  def downcase_email
    email.downcase!
  end
end
