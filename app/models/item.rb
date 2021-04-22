class Item < ApplicationRecord
  # self.table_name = "items"
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :member
  belongs_to :category
  belongs_to :department
  belongs_to :location
  has_one_attached :image
  has_one :lending
  has_many :reservations

  with_options numericality: { other_than: 0 } do
    validates :department_id
    validates :location_id
  end

  with_options numericality: { greater_than: 10 } do
    validates :category_id
  end

  # validates :content, presence: true

end