class Review < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many_attached :images

  validates :comment, presence: true,
                  length: {maximum: Settings.validation.description.length.max}
  validates :image,
            content_type: {
              in: Settings.validation.image.type,
              message: :invalid_format
            },
            size: {
              less_than: Settings.validation.image.max_size.megabytes,
              message: :required_size
            }
  validates :rating, presence: true,
            numericality: {
              greater_than_or_equal_to: Settings.validation.rating.min,
              less_than_or_equal_to: Settings.validation.rating.max
            }
end
