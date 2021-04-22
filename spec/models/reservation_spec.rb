require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#create' do
    before do
      member = FactoryBot.create(:member)
      item = FactoryBot.create(:item)
      @reservation = FactoryBot.build(:reservation, member_id: member.id, item_id: item.id)
      sleep 0.1
    end

    it "category_idとlocation_id、departmentが存在すれば登録できること" do
      expect(@reservation).to be_valid
    end

    it 'memberが必須であること(nullではない)' do
      @reservation.member_id = nil
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include('Memberを入力してください')
    end

    it 'itemが必須であること(nullではない)' do
      @reservation.item_id = nil
      @reservation.valid?
      expect(@reservation.errors.full_messages).to include('Itemを入力してください')
    end

  end
end
