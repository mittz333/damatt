class Reservation < ApplicationRecord
  belongs_to :member
  belongs_to :item
  
  with_options presence: true do
    validates :item_id
    validates :member_id
    validates :starttime
    validates :finishtime
  end

  validate :reservation_time_should_not_overlap

  private
  # 略

  def reservation_time_should_not_overlap
    return unless starttime && finishtime

    if Reservation
           .where(item_id: item_id)
           .where('starttime < ?', finishtime)
           .where('finishtime > ?', starttime)
           .where.not(id: id).exists?
      errors.add(:base, '他の予約と重複しています。')
    end
  end
end
