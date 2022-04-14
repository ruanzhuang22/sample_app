class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, presence: true,
                      length: {maximum: Settings.settings.length_max_content}
  validates :image, attached: true,
                    content_type: {in: Settings.settings.image_type,
                                   message: :invalid_format},
                    size: {less_than: Settings.settings.max_image_size
                                              .megabytes,
                           message: :large_size}
  scope :newest, ->{order(created_at: :desc)}

  def display_image
    image.variant(resize_to_limit: Settings.settings.image_size_limit)
  end
end
