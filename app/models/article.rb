class Article < ApplicationRecord

  mount_uploader :image, ImageUploader

  # Relationships
  belongs_to :user

  # Validations
  validates :name, presence: true, length: { in: 8..32 }, uniqueness: true
  validates :description, presence: true, length: { in: 16..128 }
  validates :content, presence: true, allow_blank: false

  validates_presence_of :image
  validates_integrity_of :image
  validates_processing_of :image

end
