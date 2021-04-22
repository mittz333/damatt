class Lending < ApplicationRecord
  belongs_to :member
  belongs_to :item

  with_options presence: true do
    validates :item_id
    validates :member_id
  end
end
