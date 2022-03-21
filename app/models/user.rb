class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.validates.regex.email

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.validates.length.max_name}
  validates :email, presence: true,
            length: {maximum: Settings.validates.length.max_email},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password_digest, presence: true,
            length: {minimum: Settings.validates.length.min_pass}, if: :password
  has_secure_password

  private
  def downcase_email
    email.downcase!
  end
end
