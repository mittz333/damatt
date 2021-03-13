class Member < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 belongs_to :department

 def self.guest
    find_or_create_by(email: "test@test.com") do |member|
      member.password = "123456"
      member.name = "テスト"
      member.department_id = 11
    end
  end

end
