class Member < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :lendings
  has_many :reservations
  belongs_to :department

  with_options presence: true do
    validates :name
    validates :department_id
  end

  def self.guest
    find_or_create_by(email: "test@test.com") do |member|
      member.password = "123456"
      member.name = "テスト"
      member.department_id = 11
    end
  end

end
