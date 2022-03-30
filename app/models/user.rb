class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.settings.email

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.settings.length_max_name}
  validates :email, presence: true,
            length: {maximum: Settings.settings.length_max_email},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true
  validates :password_digest, presence: true,
            length: {minimum: Settings.settings.length_min_pass}
  has_secure_password

  private
  def downcase_email
    email.downcase!
  end
end
