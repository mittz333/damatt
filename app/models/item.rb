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
  
  # validates :content, presence: true

end